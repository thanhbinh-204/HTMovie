import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/models/cast_model.dart';
import 'package:ht_movie/call_api/models/comment_model.dart';
import 'package:ht_movie/call_api/models/trailer_model.dart';
import 'package:ht_movie/call_api/services/auth_service.dart';
import 'package:ht_movie/call_api/services/cast_service.dart';
import 'package:ht_movie/call_api/services/comment_service.dart';
import 'package:ht_movie/call_api/services/movie_service.dart';
import 'package:ht_movie/call_api/services/rating_service.dart';
import 'package:ht_movie/call_api/services/trailer_service.dart';
import 'package:ht_movie/call_api/services/authstorage.dart';
import 'package:ht_movie/widget/items/item_comment/addComment.dart';
import 'package:ht_movie/widget/items/item_rating/rating_bar_item.dart';
import 'package:ht_movie/widget/items/items_detail.dart/castSection.dart';
import 'package:readmore/readmore.dart';
import '../../call_api/models/movie_model.dart';
import '../../widget/items/items_detail.dart/trailerSection.dart';
import '../../widget/items/item_rating/rating_summary_item.dart';
import '../../widget/items/item_comment/comment_list.dart';

class DetailsPage extends StatefulWidget {
  final String movieId;
  const DetailsPage({super.key, required this.movieId});
  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage> {
  // khai báo cast and trailer
  List<TrailerModel> trailers = [];
  List<CastModel> casts = [];
  bool isTrailerLoading = true;
  MovieModel? movieDetail;
  bool isLoading = true;
  String? error;

  // khai báo comment
  // khai báo controller của add comment
  final TextEditingController _commentController = TextEditingController();
  String? _userAvatar;
  List<CommentModel> comments = [];
  bool _isSending = false;
  bool isCommentLoading = true;

  // khai báo token
  String token = '';

  // khai báo rating
  double average = 0.0;
  int totalReviews = 0;
  Map<int, int> countByStar = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

  @override
  void initState() {
    super.initState();
    fetchMovieDetail();
    fetchTrailers();
    fetchCasts();
    loadToken();
    fetchRatings();
    _loadComments();
    _loadUserAvatar();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> fetchCasts() async {
    try {
      final result = await CastService.getCastsByMovieId(widget.movieId);
      setState(() {
        casts = result;
      });
    } catch (e) {
      debugPrint('fetchCasts error: $e');
    }
  }

  Future<void> fetchMovieDetail() async {
    try {
      final result = await MovieService.getMovieDetail(widget.movieId);
      setState(() {
        movieDetail = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> fetchTrailers() async {
    try {
      final result = await TrailerService.getTrailers(widget.movieId);
      setState(() {
        trailers = result;
        isTrailerLoading = false;
      });
    } catch (e) {
      setState(() {
        isTrailerLoading = false;
      });
    }
  }

  Future<void> submitRating(int score) async {
    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login to rate this movie')),
      );
      return;
    }
    try {
      final rating = await RatingService.rateMovie(
        token: token,
        movieId: widget.movieId,
        score: score,
      );
      setState(() {
        average = (rating['newAverage'] as num).toDouble();
        totalReviews = rating['totalVotes'] as int;

        final star = (score / 2).round();
        countByStar[star] = (countByStar[star] ?? 0) + 1;
      });
    } catch (e) {
      debugPrint('submit rating error: $e');
    }
  }

  Future<void> loadToken() async {
    final accessToken = await AuthService.getAccessToken();
    if (accessToken != null) {
      setState(() {
        token = accessToken;
      });
    }
  }

  Future<void> fetchRatings() async {
    try {
      final ratings = await RatingService.getRatingsByMovieId(widget.movieId);

      if (ratings.isEmpty) return;

      // reset thanh progress
      Map<int, int> starCount = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

      for (final r in ratings) {
        final score = r['score']; // 1–10
        final star = (score / 2).round().clamp(1, 5);
        starCount[star] = (starCount[star] ?? 0) + 1;
      }

      final movie = ratings.first['movie'];

      setState(() {
        average = (movie['voteAverage'] as num).toDouble();
        totalReviews = movie['voteCount'];
        countByStar = starCount;
      });
    } catch (e) {
      debugPrint('fetchRatings error: $e');
    }
  }

  Future<void> _loadUserAvatar() async {
    String? avatar = await Authstorage.getAvatar();
    setState(() {
      _userAvatar = avatar;
    });
  }

  Future<void> _handleSendComment() async {
    if (_isSending) return; // Nếu đang gửi thì không cho bấm tiếp

    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    setState(() => _isSending = true); // Bắt đầu gửi

    try {
      final token = await AuthService.getAccessToken();
      if (token == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please login to comment')));
        return;
      }

      final newComment = await CommentService.createComment(
        movieId: widget.movieId,
        content: content,
      );

      _commentController.clear();
      FocusScope.of(context).unfocus(); // Ẩn bàn phím

      setState(() {
        comments.insert(0, newComment); // Chèn comment mới lên đầu
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Comment posted!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _isSending = false);
    }
  }

  Future<void> _loadComments() async {
    try {
      final data = await CommentService.getComments(widget.movieId);
      setState(() {
        comments = data;
        isCommentLoading = false;
      });
    } catch (e) {
      setState(() => isCommentLoading = false);
      print("Error loading comments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFF191022),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF191022),
        body: Center(
          child: Text(error!, style: const TextStyle(color: Colors.white)),
        ),
      );
    }
    final movie = movieDetail!;

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.6, 1.0], // tạo tối ảnh từ đầu đến cuối
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                    const Color(0xFF191022),
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                physics: const AlwaysScrollableScrollPhysics(), // mượt
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                    ), // khoảng trống cho poster
                    _movieInfo(),
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _theloai(movie),
                    const SizedBox(height: 10),
                    _button(),
                    const SizedBox(height: 16),

                    ReadMoreText(
                      movie.overview ?? '',
                      trimLines: 3, // hiển thị tối đa 3 dòng, còn lại ...
                      trimMode: TrimMode.Line, // cắt theo dòng đã quy định là 3
                      trimCollapsedText: ' Read more',
                      trimExpandedText: ' Read less',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      moreStyle: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                      lessStyle: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Cast",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "See all",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 169, 79, 187),
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CastSection(casts: casts),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          "Official Trailer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TrailerSection(
                      isTrailerLoading: isTrailerLoading,
                      trailers: trailers,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Ratings & Reviews",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    RatingSummaryItem(
                      average: average,
                      totalReviews: totalReviews,
                      countByStar: countByStar,
                    ),
                    RatingBarItem(onRate: submitRating),
                    SizedBox(height: 25),
                    // add comment
                    if (token.isNotEmpty)
                      Addcomment(
                        controller: _commentController,
                        avatarUrl: _userAvatar,
                        isSending: _isSending,
                        onSend: _handleSendComment,
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Please login to comment',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),

                    // hiển thị comment
                    // Thay cho FutureBuilder cũ:
                    if (isCommentLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (comments.isEmpty)
                      const Center(
                        child: Text(
                          'Chưa có comment nào',
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    else
                      CommentList(comments: comments),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),

          // thiết lập _topbar cứng ở trên đầu không bị di chuyển
          // vẫn hiển thị và bấm được khi các nd khác được scroll lên
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: _topbar(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topbar(BuildContext context) {
    return Row(
      children: [
        IconButton.outlined(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          style: IconButton.styleFrom(padding: EdgeInsets.only(left: 7)),
        ),
        const Spacer(),
        IconButton.outlined(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.white, size: 22),
        ),
        IconButton.outlined(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, color: Colors.white, size: 22),
        ),
      ],
    );
  }

  Widget _movieInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 4K HDR + rating
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "4K HDR",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.star_border_rounded,
              color: Colors.amber,
              size: 18,
            ),
            const SizedBox(width: 4),
            const Text("4.8", style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }

  Widget _theloai(MovieModel movie) {
    final List<Widget> chips = [];
    for (final genre in movie.genres) {
      chips.add(_chip(genre.name));
    }
    if (movie.runtime > 0) {
      final hours = movie.runtime ~/ 60;
      final minutes = movie.runtime % 60;
      chips.add(_chip('${hours}h ${minutes}m'));
    }
    if (movie.releaseDate.isNotEmpty) {
      final year = movie.releaseDate.split('-').first;
      chips.add(_chip(year));
    }
    return Wrap(spacing: 8, children: chips);
  }

  Widget _button() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              print('watch now');
            },
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            label: const Text(
              "Watch Movie",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _circleButton(
          icon: Icons.favorite_border,
          onTap: () {
            print("save movie");
          },
        ),
        const SizedBox(width: 8),
        _circleButton(icon: Icons.share, onTap: () {}),
      ],
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

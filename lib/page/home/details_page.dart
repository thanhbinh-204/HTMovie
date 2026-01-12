import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/models/cast_model.dart';
import 'package:ht_movie/call_api/models/trailer_model.dart';
import 'package:ht_movie/call_api/services/movie_service.dart';
import 'package:ht_movie/call_api/services/trailer_service.dart';
import 'package:ht_movie/widget/items/items_home/trailer_player_page.dart';
import 'package:readmore/readmore.dart';
import '../../call_api/models/movie_model.dart';

class DetailsPage extends StatefulWidget {
  final String movieId;
  const DetailsPage({super.key, required this.movieId});
  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage> {
  List<TrailerModel> trailers = [];
  bool isTrailerLoading = true;
  MovieModel? movieDetail;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchMovieDetail();
    fetchTrailers();
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
                          "Top Cast",
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
                    _castSetion(context, movie.cast),
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
                    _trailerSection(context),
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

  //item cast api
  Widget _castSetion(BuildContext context, List<CastModel> casts) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;
    final double avatarWidth =
        isTablet
            ? 90
            : isSmallPhone
            ? 60
            : 70;
    final double avatarHeight =
        isTablet
            ? 120
            : isSmallPhone
            ? 80
            : 90;
    final double textWidth =
        isTablet
            ? 110
            : isSmallPhone
            ? 80
            : 90;
    final double fontSize =
        isTablet
            ? 14
            : isSmallPhone
            ? 11
            : 12;
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cast = casts[index];
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:
                    cast.profileUrl == null || cast.profileUrl!.isEmpty
                        ? Container(
                          width: avatarWidth,
                          height: avatarHeight,
                          color: Colors.grey.shade800,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white54,
                          ),
                        )
                        : Image.network(
                          cast.profileUrl!,
                          width: avatarWidth,
                          height: avatarHeight,
                          fit: BoxFit.cover,
                        ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: textWidth,
                child: Text(
                  cast.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70, fontSize: fontSize),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //widget hiển thị trailer
  Widget _trailerSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    final double trailerHeight =
        isTablet
            ? 220
            : isSmallPhone
            ? 150
            : 180;
    final double trailerWidth =
        isTablet
            ? 380
            : isSmallPhone
            ? 260
            : 300;
    final double textFontSize =
        isTablet
            ? 14
            : isSmallPhone
            ? 12
            : 13;

    if (isTrailerLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (trailers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            "Chưa có trailer ",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      );
    }

    final trailer = trailers.first;

    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => TrailerPlayerPage(
                    youtubeUrl: trailer.youtubeUrl,
                    title: trailer.title,
                  ),
            ),
          );
        },
        child: Container(
          width: trailerWidth,
          height: trailerHeight,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            image:
                trailer.thumbnail != null
                    ? DecorationImage(
                      image: NetworkImage(trailer.thumbnail!),
                      fit: BoxFit.cover,
                    )
                    : null,
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ht_movie/widget/items/items_home/trailer_player_page.dart';

class TrailerSection extends StatelessWidget {
  final bool isTrailerLoading;
  final List<dynamic> trailers; // hoặc List<TrailerModel>

  const TrailerSection({
    super.key,
    required this.isTrailerLoading,
    required this.trailers,
  });

  @override
  Widget build(BuildContext context) {
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

    if (isTrailerLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (trailers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            "Chưa có trailer",
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
              builder: (_) => TrailerPlayerPage(
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
            image: trailer.thumbnail != null
                ? DecorationImage(
                    image: NetworkImage(trailer.thumbnail!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: const Center(
            child: Icon(
              Icons.play_circle_fill,
              size: 64,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

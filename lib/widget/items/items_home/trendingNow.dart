import 'package:flutter/material.dart';
import '../../../call_api/models/movie_model.dart';
import '../../../call_api/services/movie_service.dart';
import '../../../page/home/details_page.dart';

class Trendingnow extends StatelessWidget {
  const Trendingnow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return SizedBox(
      height: isSmallPhone ? 180 : (isTablet ? 290 : 260),
      child: FutureBuilder<List<MovieModel>>(
        future: MovieService.getAllMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          final movies = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return Container(
                width: isTablet ? 250 : 195,
                margin: EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(builder: (_) => DetailsPage(movieId: movie.id,)),
                            );
                          },
                          child: Image.network(
                            movie.posterUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder:
                                (_, _, __) => const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      movie.releaseDate.split('-').first,
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

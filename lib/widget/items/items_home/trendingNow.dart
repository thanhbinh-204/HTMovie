import 'package:flutter/material.dart';
import '../../../call_api/models/movie_model.dart';
import '../../../call_api/services/movie_service.dart';

class Trendingnow extends StatelessWidget {
  const Trendingnow({super.key});

  @override
  Widget build(BuildContext context) {
    // film
    // final List<Map<String, dynamic>> film = [
    //   {
    //     'name': 'Avatar:The Way of Water',
    //     'image':
    //         'https://i.pinimg.com/736x/fe/75/db/fe75dbce2802cbdc52ed568c9d845ab8.jpg',
    //     'rate': '4,5',
    //     'year': '2022',
    //   },
    //   {
    //     'name': 'Arrival',
    //     'image':
    //         'https://i.pinimg.com/736x/a8/a7/64/a8a7647887be44a8bedef093cd92f271.jpg',
    //     'rate': '4,8',
    //     'year': '2021',
    //   },
    //   {
    //     'name': 'The Wave',
    //     'image':
    //         'https://i.pinimg.com/736x/64/59/81/645981a04bd9f5d661ce7c540c6eef64.jpg',
    //     'rate': '4,1',
    //     'year': 'The Wave',
    //   },
    //   {
    //     'name': 'Train To BuSan',
    //     'image':
    //         'https://i.pinimg.com/736x/94/7d/5d/947d5d686167747afbab5a78b9fe68b9.jpg',
    //     'rate': '4,9',
    //     'year': '2014',
    //   },
    // ];
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return SizedBox(
      height: isSmallPhone ? 180 : (isTablet ? 290 : 260),
      child: FutureBuilder<List<MovieModel>>(
        future: MovieService.getAllMovies(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                            print("nhấn film qua details");
                          },
                          child: Image.network(movie.posterUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (_, _, __) => 
                          const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      ),
                      SizedBox(height: 6,),
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
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      )
                  ],
                ),
              ); 
            }
            );
        }
        )
    );
  }
}

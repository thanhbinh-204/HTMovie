// import 'package:flutter/material.dart';
// import 'package:ht_movie/call_api/models/movie_model.dart';

// class MovieCard extends StatelessWidget {
//   final MovieModel movie;
//   final bool isTablet;
//   final bool isSmallPhone;

//   const MovieCard({
//     required this.movie,
//     required this.isTablet,
//     required this.isSmallPhone,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(isTablet ? 28 : 22),
//                 child: Image.network(
//                   movie.posterUrl,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: isSmallPhone ? 8 : 10,
//                 right: isSmallPhone ? 8 : 10,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: isSmallPhone ? 6 : 8,
//                     vertical: isSmallPhone ? 3 : 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.7),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber, size: 14),
//                       SizedBox(width: 4),
//                       Text(
//                         '8.7',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           movie.title,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: isTablet ? 16 : 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           movie.releaseDate.split('-').first,
//           style: TextStyle(color: Colors.white54, fontSize: isTablet ? 13 : 12),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool isTablet;
  final bool isSmallPhone;

  const MovieCard({
    required this.movie,
    required this.isTablet,
    required this.isSmallPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(isTablet ? 28 : 22),
                child: movie.posterUrl.isEmpty
                    ? Container(
                        color: Colors.grey.shade800,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.movie,
                          color: Colors.white54,
                          size: 40,
                        ),
                      )
                    : Image.network(
                        movie.posterUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: Colors.grey.shade800,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.white54,
                              size: 40,
                            ),
                          );
                        },
                      ),
              ),

              // rating (fake / tạm)
              Positioned(
                top: isSmallPhone ? 8 : 10,
                right: isSmallPhone ? 8 : 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallPhone ? 6 : 8,
                    vertical: isSmallPhone ? 3 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'N/A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          movie.releaseDate.isNotEmpty
              ? movie.releaseDate.split('-').first
              : '',
          style: TextStyle(
            color: Colors.white54,
            fontSize: isTablet ? 13 : 12,
          ),
        ),
      ],
    );
  }
}

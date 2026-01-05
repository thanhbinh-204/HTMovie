import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SavemovieLibrary extends StatelessWidget {
  const SavemovieLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> save_movies = [
      {
        'title': 'Blade Runner 2049',
        'image':
            'https://i.pinimg.com/736x/e7/0d/34/e70d34ec7f4b85248744351ec42a44dc.jpg',
        'genre': 'Sci-Fi',
        'year': '2017',
      },
      {
        'title': 'Arrival',
        'image':
            'https://i.pinimg.com/736x/a8/a7/64/a8a7647887be44a8bedef093cd92f271.jpg',
        'genre': 'Sci-Fi',
        'year': '2021',
      },
      {
        'title': 'The Wave',
        'image':
            'https://i.pinimg.com/736x/64/59/81/645981a04bd9f5d661ce7c540c6eef64.jpg',
        'genre': 'Sci-Fi',
        'year': '2018',
      },
      {
        'title': 'Train To BuSan',
        'image':
            'https://i.pinimg.com/736x/94/7d/5d/947d5d686167747afbab5a78b9fe68b9.jpg',
        'genre': 'Sci-Fi',
        'year': '2014',
      },
    ];
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return SizedBox(
      height: isSmallPhone ? 180 : (isTablet ? 290 : 260),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: save_movies.length,
        itemBuilder: (context, index) {
          final item = save_movies[index];

          return Container(
            width: isTablet ? 250 : 195,
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () {
                        print(" nhấn save movies in library");
                      },
                      child: Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                      '${item['title']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 12 : 10,
                      ),
                      ),
                Row(
                  children: [
                    Text(
                      '${item['genre']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: isTablet ? 10 : 8
                      ),
                    ),
                    _dot(),
                    Text(
                      '${item['year']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: isTablet ? 10 : 8
                      ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Text('•', style: TextStyle(color: Colors.white70)),
  );
}

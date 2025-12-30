import 'package:flutter/material.dart';

class Trendingnow extends StatelessWidget {
  const Trendingnow({super.key});

  @override
  Widget build(BuildContext context) {
    // film
    final List<Map<String, dynamic>> film = [
      {
        'name': 'Avatar:The Way of Water',
        'image':
            'https://i.pinimg.com/736x/fe/75/db/fe75dbce2802cbdc52ed568c9d845ab8.jpg',
        'rate': '4,5',
        'year': '2022',
      },
      {
        'name': 'Arrival',
        'image':
            'https://i.pinimg.com/736x/a8/a7/64/a8a7647887be44a8bedef093cd92f271.jpg',
        'rate': '4,8',
        'year': '2021',
      },
      {
        'name': 'The Wave',
        'image':
            'https://i.pinimg.com/736x/64/59/81/645981a04bd9f5d661ce7c540c6eef64.jpg',
        'rate': '4,1',
        'year': '2018',
      },
      {
        'name': 'Train To BuSan',
        'image':
            'https://i.pinimg.com/736x/94/7d/5d/947d5d686167747afbab5a78b9fe68b9.jpg',
        'rate': '4,9',
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
        itemCount: film.length,
        itemBuilder: (context, index) {
          final item = film[index];

          return Container(
            width: isTablet ? 250 : 195,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: (){
                        print("nhấn film đến details");
                      },
                    child: Image.network(
                      item['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    ),
                  )
                  )
              ],
            ),
          );
        }
        ),
    );
  }
}

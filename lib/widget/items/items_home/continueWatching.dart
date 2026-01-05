import 'package:flutter/material.dart';

class Continuewatching extends StatelessWidget {
  const Continuewatching ({super.key});

  @override
  Widget build(BuildContext context) {

    //continue watching
  final List<Map<String, dynamic>> ctnWatching = [
    {
      'name' : 'Dune:Part One',
      'image': 'https://i.pinimg.com/736x/47/da/2d/47da2d09a9bb2394dd764adc789ab193.jpg',
      'time' : '1h34m remaining',
    },
    {
      'name' : 'Dune:Part One',
      'image': 'https://i.pinimg.com/736x/b1/ac/5b/b1ac5b489ce5b989680b6ca81a49e180.jpg',
      'time' : '1h34m remaining',
    },
    {
      'name' : 'Dune:Part One',
      'image': 'https://i.pinimg.com/736x/ca/49/1d/ca491d45d50bbf2b1d05a5c7432ad817.jpg',
      'time' : '1h34m remaining',
    },
    {
      'name' : 'Dune:Part One',
      'image': 'https://i.pinimg.com/736x/b2/a5/1e/b2a51ed349764f3536e7ac57130fc521.jpg',
      'time' : '1h34m remaining',
    },
  ];

    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    return SizedBox(
      height: isSmallPhone ? 180 : (isTablet ? 250 : 220), // chiều cao height 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: ctnWatching.length,
        itemBuilder: (context, index) {
          final item = ctnWatching[index];

          return Container(
            width: isTablet ? 260 : 225,                      // chiều ngang rộng width 
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ),
                  
                  SizedBox(height: 8,),

                  Text(
                    item['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 8,),

                  Text(
                    item['time'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  )
              ],
            ),
          );
        }
        ),
    );
  }
}
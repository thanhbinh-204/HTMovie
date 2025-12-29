import 'package:flutter/material.dart';
import 'package:ht_movie/items/category_section.dart';
import '../items/hero_banner.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  
  // dữ liệu film test all home page
  
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

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeroBanner(),
            SizedBox(height: 16,),
            CategorySection(),
            SizedBox(height: 16,),
            Row(
              
              children: [
                Padding(padding: EdgeInsets.only(left: isTablet ? 20 : 16)),
                Text(
                  "Continue Watching", 
                  style: TextStyle(color: Colors.white),
                  
                  ),
                
                Padding(padding: EdgeInsets.only(left: isTablet ? 20 : 65),
                child: Text(
                  "See All",
                   style: TextStyle(color:const Color.fromARGB(255, 169, 79, 187)),
                   )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

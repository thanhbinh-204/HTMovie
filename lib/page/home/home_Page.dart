import 'package:flutter/material.dart';
import 'package:ht_movie/widget/items/items_home/category_section.dart';
import '../../widget/items/items_home/hero_banner.dart';
import '../../widget/items/items_home/continueWatching.dart';
import '../../widget/items/items_home/trendingNow.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // hero banner film
              const HeroBanner(),
              SizedBox(height: 16),
              // categopry film
              CategorySection(),
              SizedBox(height: 16),
              // header continue watching and see all
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: isTablet ? 20 : 16)),
                  Text(
                    "Continue Watching",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: isTablet ? 20 : 16),
                    child: Text(
                      "See All",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 169, 79, 187),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              //continue watching
              Continuewatching(),
              SizedBox(height: 16),
              // header trending nơw
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: isTablet ? 20 : 16)),
                  Text(
                    "Trending Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: isTablet ? 10 : 5),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_left),
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: const Color.fromARGB(255, 133, 132, 132),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: isTablet ? 20 : 16),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_right),
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: const Color.fromARGB(255, 133, 132, 132),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Trendingnow(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

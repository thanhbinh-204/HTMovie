import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    // category
    final List<String> categories = [
      'All',
      'Movie',
      'Live Aciton',
      'Khoa Học',
      'Anime',
      'Kinh Dị',
      'Phiêu Lưu',
      'Tình Cảm',
      'Dài Tập',
      'Sci-Fi',
      'Comedy',
      'TV Shows',
      'Top Rated',
    ];

    return SizedBox(
      height: isTablet ? 48 : isSmallPhone ? 34 : 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10,),
        itemBuilder: (context, index) {
          final bool isActive = index == 0;

          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 20 : isSmallPhone ? 12 : 16,
              // thêm vertical sẽ bị đẩy text
            ),
            decoration: BoxDecoration(
              color: isActive ? const Color.fromARGB(255, 169, 79, 187) : Colors.transparent, 
              border: Border.all(
                color: isActive ? Colors.transparent : Colors.white.withOpacity(0.4),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                categories[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 14 : isSmallPhone ? 10 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
          
        },
        ),
    );
  }
}

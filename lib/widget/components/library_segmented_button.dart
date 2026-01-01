import 'package:flutter/material.dart';

class LibrarySegmentedButton extends StatefulWidget {
  const LibrarySegmentedButton({super.key});

  @override
  State<StatefulWidget> createState() => _LibrarySegmentedButton();
}

class _LibrarySegmentedButton extends State<LibrarySegmentedButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    final double height = isTablet ? 64 : isSmallPhone ? 48 : 56;
    final double fontSize = isTablet ? 16 : isSmallPhone ? 10 : 12;
    final double radius = isTablet ? 26 : 30;
    final double itemRadius = isTablet ? 22 : 20;

    return Container(
      height: height,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.white10,
          width: 1.2,
        )
      ),
      child: Row(
        children: [
          _buildItem("Favourites", 0, fontSize, itemRadius),
          _buildItem("Watch History", 1, fontSize, itemRadius)
        ],
      ),
    );
  }



  Widget _buildItem(
    String title,
    int index,
    double fontSize,
    double itemRadius,
  ) {
    final bool isActive = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() => selectedIndex = index);
          },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFFA855F7) : Colors.transparent,
            borderRadius: BorderRadius.circular(itemRadius),
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: fontSize
            ),
          ),
          ),
      ),
      );
  }
}

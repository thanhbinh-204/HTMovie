import 'package:flutter/material.dart';

class RatingBarItem extends StatefulWidget {
  final void Function(int score) onRate;

  RatingBarItem({super.key, required this.onRate});

  @override
  State<RatingBarItem> createState() => _RatingBarItemState();
}

class _RatingBarItemState extends State<RatingBarItem> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;

    final double iconSize = isTablet ? 36 : 30;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final star = index + 1;
        return IconButton(
          onPressed: () {
            setState(() => selected = star);
            widget.onRate(star * 2);
          },
          icon: Icon(
            star <= selected ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: iconSize,
          ),
        );
      }),
    );
  }
}

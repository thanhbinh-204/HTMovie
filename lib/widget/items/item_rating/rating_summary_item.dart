import 'package:flutter/material.dart';

class RatingSummaryItem extends StatelessWidget {
  final double average;
  final int totalReviews;
  final Map<int, int> countByStar;

  const RatingSummaryItem({
    super.key,
    required this.average,
    required this.totalReviews,
    required this.countByStar,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    final double averageFontSize =
        isTablet
            ? 48
            : isSmallPhone
            ? 34
            : 42;
    final double starSize = isTablet ? 24 : 20;
    final double progressHeight = isTablet ? 10 : 8;
    final displayAverage = average / 2;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayAverage.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: averageFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(
                  5,
                  (_) => Icon(Icons.star, color: Colors.amber, size: starSize),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$totalReviews reviews',
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                final star = 5 - index;
                final count = countByStar[star] ?? 0;
                final double progress =
                    totalReviews == 0 ? 0 : count / totalReviews;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        '$star',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(width: 6),

                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: progressHeight,
                            backgroundColor: Colors.white12,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

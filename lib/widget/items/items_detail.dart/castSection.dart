import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/models/cast_model.dart';

class CastSection extends StatelessWidget {
  final List<CastModel> casts;

  const CastSection({
    super.key,
    required this.casts,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    final double avatarWidth =
        isTablet
            ? 90
            : isSmallPhone
                ? 60
                : 70;

    final double avatarHeight =
        isTablet
            ? 120
            : isSmallPhone
                ? 80
                : 90;

    final double textWidth =
        isTablet
            ? 110
            : isSmallPhone
                ? 80
                : 90;

    final double fontSize =
        isTablet
            ? 14
            : isSmallPhone
                ? 11
                : 12;

    if (casts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            "Chưa có diễn viên",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cast = casts[index];

          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: cast.profileUrl == null || cast.profileUrl!.isEmpty
                    ? Container(
                        width: avatarWidth,
                        height: avatarHeight,
                        color: Colors.grey.shade800,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white54,
                        ),
                      )
                    : Image.network(
                        cast.profileUrl!,
                        width: avatarWidth,
                        height: avatarHeight,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: textWidth,
                child: Text(
                  cast.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

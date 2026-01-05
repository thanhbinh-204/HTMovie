import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isSmallPhone = size.width < 360;
    final bool isTablet = size.width >= 600;

    final movie = {
      'title': 'Blade Runner 2049',
      'image':
          'https://i.pinimg.com/736x/e7/0d/34/e70d34ec7f4b85248744351ec42a44dc.jpg',
      'match': '98%',
      'year': '2017',
      'quality': '4K',
      'duration': '2h 44m',
      'genre': 'Sci-Fi',
    };

    final double bannerHeight =
        isTablet ? size.height * 0.45 : size.height * 0.55;

    return Stack(
      children: [
        // BACKGROUND IMAGE
        SizedBox(
          height: bannerHeight,
          width: double.infinity,
          child: Image.network(movie['image']!, fit: BoxFit.cover),
        ),

        // GRADIENT
        Container(
          height: bannerHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xFF191022)],
            ),
          ),
        ),

        // CONTENT
        Positioned(
          left: 16,
          right: 16,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TAG
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '#1 IN MOVIES TODAY',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // TITLE (NO WRAP)
              Text(
                movie['title']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontSize: isSmallPhone ? 15 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // INFO ROW (NO WRAP)
              Row(
                children: [
                  Text(
                    '${movie['match']} Match',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(width: 5),
                  _infoText(movie['year']!),
                  _dot(),
                  _infoText(movie['quality']!),
                  _dot(),
                  _infoText(movie['duration']!),
                  _dot(),
                  _infoText(movie['genre']!),
                ],
              ),

              const SizedBox(height: 14),

              // BUTTONS
              Row(
                children: [
                  _actionButton(
                    icon: Icons.play_arrow,
                    label: 'Watch Now',
                    isPrimary: true,
                    isSmallPhone: isSmallPhone,
                  ),
                  const SizedBox(width: 12),
                  _actionButton(
                    icon: Icons.info_outline,
                    label: 'Details',
                    isPrimary: false,
                    isSmallPhone: isSmallPhone,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Text('•', style: TextStyle(color: Colors.white70)),
  );

  Widget _infoText(String text) => Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(color: Colors.white70, fontSize: 10),
  );

  Widget _actionButton({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required bool isSmallPhone,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: isSmallPhone ? 16 : 18),
        label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: isSmallPhone ? 10 : 12),),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary
                  ? const Color.fromARGB(255, 169, 79, 187)
                  : Colors.transparent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: isSmallPhone ? 8 : 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: // viền màu cho details
                isPrimary
                    ? BorderSide.none
                    : BorderSide(
                      color: const Color.fromARGB(255, 133, 132, 132),
                      width: 1.2,
                    ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final Widget value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final labelWidth = constraints.maxWidth * 0.4;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: labelWidth,
              child: Text(
                label,
                style: const TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(child: value),
          ],
        );
      },
    );
  }
}

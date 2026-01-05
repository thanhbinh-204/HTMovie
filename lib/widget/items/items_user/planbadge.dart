import 'package:flutter/material.dart';

class Planbadge extends StatelessWidget {
  final String plan;

  const Planbadge({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFFB46CFF), 
            Color(0xFF8A4DFF)
            ],
        ),
      ),
      child: Text(
        plan,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1
        ),
      ),
    );
  }
}

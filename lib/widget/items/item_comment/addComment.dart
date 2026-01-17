import 'package:flutter/material.dart';

class Addcomment extends StatelessWidget {
  final VoidCallback onSend;
  final TextEditingController controller;
  final String? avatarUrl;
  final bool isSending;

  const Addcomment({
    super.key,
    required this.onSend,
    required this.controller,
    this.avatarUrl,
    this.isSending = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 20 : 12,
        horizontal: isTablet ? 24 : 12,
      ),
      child: Row(
        children: [
          /// AVATAR
          CircleAvatar(
            radius: isTablet ? 26 : 22,
            backgroundColor: Colors.white12,
            backgroundImage:
                (avatarUrl != null && avatarUrl!.isNotEmpty)
                    ? NetworkImage(avatarUrl!)
                    : null,
            child: (avatarUrl == null || avatarUrl!.isEmpty)
                ? const Icon(Icons.person, color: Colors.white70)
                : null,
          ),

          const SizedBox(width: 12),

          /// INPUT
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20 : 16,
                vertical: isTablet ? 14 : 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: controller,
                enabled: !isSending,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 16 : 14,
                ),
                decoration: const InputDecoration(
                  hintText: 'Add a comment...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// SEND BUTTON
          GestureDetector(
            onTap: isSending ? null : onSend,
            child: Container(
              width: isTablet ? 52 : 44,
              height: isTablet ? 52 : 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSending
                    ? Colors.white24
                    : const Color(0xFF8F4AE8),
              ),
              child: isSending
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: isTablet ? 26 : 22,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

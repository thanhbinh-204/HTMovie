import 'package:flutter/material.dart';
import 'security_item.dart';

class SecurityUser extends StatelessWidget {
  const SecurityUser({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return Container(
      padding: EdgeInsets.all(isTablet ? 28 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1C1F3A), Color(0xFF12132A)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lock_outline,
                color: Color(0xFFB46CFF),
                size: isTablet ? 24 : 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Security',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 22 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallPhone ? 16 : 20),
          SecurityItem(icon: Icons.edit, title: 'Edit Profile', onTap: () {
            print("nhấn edit profile");
          }),
          SizedBox(height: 14),
          SecurityItem(icon: Icons.lock_outline, title: 'Change Password',onTap: () {
            print("nhấn change password");
          },),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'security_item.dart';
import '../../../page/navbar_page/editprofile_user_page.dart';
import '../../../page/navbar_page/change_pass_page.dart';

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
          SecurityItem(
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: EditprofileUserPage(),
                withNavBar: false, // không kèm navbar theo khi chuyển trang
              );
            },
          ),
          SizedBox(height: 14),

          SecurityItem(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ChangePassPage(),
                withNavBar: false, // không kèm navbar theo khi chuyển trang
              );
            },
          ),
        ],
      ),
    );
  }
}

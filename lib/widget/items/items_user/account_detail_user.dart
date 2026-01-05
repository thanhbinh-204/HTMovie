import 'package:flutter/material.dart';
import 'inforow.dart';
import 'planbadge.dart';

class AccountDetailUser extends StatelessWidget {
  const AccountDetailUser({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    //mock data sau thay bằng api user đăng nhập
    const username = '@htmovie_fan_99';
    const memberSince = 'October 2022';
    const plan = 'Premium 4K';

    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFB46CFF).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_circle,
                  color: Color(0xFFB46CFF),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Account Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 20 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InfoRow(
            label: 'Username',
            value: Text(
              username,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          _divier(),

          InfoRow(
            label: 'Member Since',
            value: Text(
              memberSince,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          _divier(),
          InfoRow(label: 'Plan', value: Planbadge(plan: plan)),
        ],
      ),
    );
  }

  Widget _divier() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Divider(color: Colors.white.withOpacity(0.08), height: 1),
  );
}

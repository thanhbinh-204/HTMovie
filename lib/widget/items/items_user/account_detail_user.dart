import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/api/api_client.dart';
import 'package:ht_movie/call_api/api/usercache.dart';
import 'package:ht_movie/page/regis_login_page/Login_page.dart';
import 'inforow.dart';
import 'planbadge.dart';
import '../../../call_api/models/user_model.dart';
import '../../../call_api/services/user_service.dart';

class AccountDetailUser extends StatefulWidget {
  const AccountDetailUser({super.key});

  @override
  State<StatefulWidget> createState() => _AccountDetailUserState();
}

class _AccountDetailUserState extends State<AccountDetailUser> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await UserService.getProfile();

      UserCache.currentUser = result;

      if (!mounted) return;

      setState(() {
        user = result;
        isLoading = false;
      });
    } on UnauthenticatedException {
      handleUnauthenticated();
    } catch (e) {
      debugPrint('FETCH USER ERROR: $e');
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  void handleUnauthenticated() {
    UserCache.currentUser = null;
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  } // nếu token hết hạn user null thì điều hướng về login

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (user == null) {
      return Center(
        child: Text(
          'Không có thông tin tài khoản',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    final username = user!.name ?? user!.email;
    final memberSince =
        '${user!.createdAt.day}/${user!.createdAt.month}/${user!.createdAt.year}';
    final plan = 'Free';

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
              maxLines: 1,
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

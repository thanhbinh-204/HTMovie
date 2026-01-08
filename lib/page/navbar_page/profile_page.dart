import 'package:flutter/material.dart';
import 'package:ht_movie/page/regis_login_page/Login_page.dart';
import '../../widget/items/items_user/account_detail_user.dart';
import '../../widget/items/items_user/security_user.dart';
import '../../widget/components/imagepicker_user.dart';
import '../../widget/components/custom_components.dart';
import '../../call_api/services/authstorage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Color(0xFF191022),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isTablet ? 20 : 12),
            child: IconButton.outlined(
              onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 16,
            vertical: isSmallPhone ? 16 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImagePickerUser(),

              SizedBox(height: 24),

              const AccountDetailUser(),

              SizedBox(height: 20),

              const SecurityUser(),

              SizedBox(height: 30),
              CustomButton(
                text: "Log out",
                onPressed: () async {
                  await Authstorage.logout();
                  if (!context.mounted) return;

                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                  );
                },
              ),

              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

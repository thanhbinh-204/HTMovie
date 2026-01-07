import 'package:flutter/material.dart';
import '../../call_api/authstorage.dart';
import '../navbar_page/navbar.dart';
import '../regis_login_page/Login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await Authstorage.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => isLoggedIn ? Navbar() : LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    final double iconSize =
        isTablet
            ? 90
            : isSmallPhone
            ? 48
            : 64;

    final double titleSize =
        isTablet
            ? 40
            : isSmallPhone
            ? 26
            : 32;

    final double subtitleSize =
        isTablet
            ? 18
            : isSmallPhone
            ? 12
            : 14;

    final double spacingLarge = isSmallPhone ? 24 : 40;
    final double spacingMedium = isSmallPhone ? 16 : 24;

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isSmallPhone ? 14 : 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurpleAccent.withOpacity(0.15),
              ),
              child: Icon(
                Icons.movie_creation_rounded,
                size: iconSize,
                color: Colors.deepPurpleAccent,
              ),
            ),

            SizedBox(height: spacingMedium),

            Text(
              'HT Movie',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Enjoy Your Cinema',
              style: TextStyle(
                fontSize: subtitleSize,
                color: Colors.white54,
                letterSpacing: 1.2,
              ),
            ),

            SizedBox(height: spacingLarge),

            SizedBox(
              width: isSmallPhone ? 20 : 24,
              height: isSmallPhone ? 20 : 24,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepPurpleAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

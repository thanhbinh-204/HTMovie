import 'package:flutter/material.dart';
import 'package:ht_movie/page/regis_login_page/Login_page.dart';
import 'package:ht_movie/widget/components/custom_components.dart';

class ForgotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPage();
}

class _ForgotPage extends State<ForgotPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailForget = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? size.width * 0.2 : size.width * 0.05,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFoget(
                    titleForget: "Forgot Password",
                    subtitleForget:
                        "Enter the email associated with your account and we’ll send instructions to reset your password.",
                  ),
                  Container(
                    padding: EdgeInsets.all(isSmallPhone ? 20 : 32),
                    decoration: BoxDecoration(
                      color: Color(0xFF252A4A),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailForget,
                            labelText: "Email Address",
                            hintText: "example@gmail.com",
                            icon: Icons.email_outlined,
                          ),
                          SizedBox(height: isSmallPhone ? 15 : 20),
                          CustomButton(
                            text: "Send Reset Link",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  RedirectLink(
                    leadingText: "Remember your password?",
                    linkText: "Login",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

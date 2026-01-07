import 'package:flutter/material.dart';
import 'package:ht_movie/page/home/home_Page.dart';
import 'Register_page.dart';
import '../../widget/components/custom_components.dart';
import '../password/forgot_page.dart';
import '../../call_api/services/auth_service.dart';
import '../navbar_page/navbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailLoginVLD = TextEditingController();
  final _passwordLoginVLD = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;

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
                  CustomLogo(
                    title: "Welcome Back",
                    subtitle:
                        "Please sign in to your HTMovie account to\ncontinue watching.",
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
                            controller: _emailLoginVLD,
                            labelText: "Email or Username",
                            hintText: "name@example.com",
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email or Username cannot be empty";
                              }
                              if (value.contains('@')) {
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return "Invalid email format";
                                }
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: isSmallPhone ? 15 : 20),

                          SizedBox(height: 8),

                          CustomTextField(
                            controller: _passwordLoginVLD,
                            labelText: "Password",
                            hintText: "Enter your password",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            isObscured: _isObscure,
                            onToggle: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xFF9D50FF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 32),
                          CustomButton(
                            text: "Login",
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() => _isLoading = true);

                                try {
                                  final reponse = await AuthService.login(
                                    email: _emailLoginVLD.text.trim(), 
                                    password: _passwordLoginVLD.text,
                                    );
                                    print("Login Success");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Login Success")),
                                    );
                                    Navigator.pushReplacement(context, 
                                    MaterialPageRoute(builder: (_) => Navbar()),
                                    );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Email or password is incorrect",
                                      ),
                                    ),
                                  );
                                } finally {
                                  setState(() => _isLoading = false);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  RedirectLink(
                    leadingText: "New to HTMovie?",
                    linkText: "Create an Account",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

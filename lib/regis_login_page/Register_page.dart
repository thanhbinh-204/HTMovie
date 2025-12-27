import 'package:flutter/material.dart';
import 'Login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailVLD = TextEditingController();
  final _passwordVLD = TextEditingController();
  final _repeatPass = TextEditingController();

  bool _isLoading = false;
  bool _obPassword = true;

  // xử lý ẩn hiện mật khẩu
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

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
                  SizedBox(height: 20,),
                  _buildLogo(size),
                  Container(
                    padding: EdgeInsets.all(isSmallPhone ? 20 : 32),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252A4A),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Email or Username"),
                          SizedBox(height: 8),
                          _buildTextField(
                            controller: _emailVLD,
                            hintText: "name@example.com",
                            icon: Icons.email_outlined,
                          ),
                          SizedBox(height: isSmallPhone ? 15 : 20),

                          _buildLabel("Password"),
                          SizedBox(height: 8),
                          _buildTextField(
                            controller: _passwordVLD,
                            hintText: "Enter your password",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            isObscured : _obscurePassword,
                            onToggle: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          SizedBox(height: isSmallPhone ? 15 : 20),

                          _buildLabel("Repeat Password"),
                          SizedBox(height: 8),
                          _buildTextField(
                            controller: _repeatPass,
                            hintText: "Enter your repeat password",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            isObscured : _obscurePassword,
                            onToggle: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          SizedBox(height: 24),
                          _buildRequirementBox(),
                          SizedBox(height: 32),
                          _buildRegisterButton(size),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildLoginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo (Size size) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          // padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9D50FF), Color(0xFF6E48FF)],
              ),
              boxShadow : [
                BoxShadow(
                  color: Color(0xFF9D50FF).withOpacity(0.5),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
          ),
          child: Image.asset(
            "assets/images/logo.png",
            color: Colors.white,
            fit: BoxFit.contain,
            ),
        ),
        SizedBox(height: 16,),
        Text("Register",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ),
        SizedBox(height: 24,),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isObscured = false,  //biến trạng thái mới
    VoidCallback? onToggle,   // xử lý click ẩn hiện pass
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isObscured : false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.white38, size: 20),
        suffixIcon: isPassword
                ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.white38,
                    size: 20,
                  ),
                  onPressed: onToggle,
                )
                : null,
        filled: true,
        fillColor: const Color(0xFF1E2342),
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFF9D50FF)),
        ),
      ),
    );
  }

  Widget _buildRequirementBox() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF9D50FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF9D50FF).withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Color(0xFF9D50FF), size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Password must be at least 8 characters long and include a mix of letters, numbers, and symbols.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(Size size) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Color(0xFF9D50FF), Color(0xFF6E48FF)],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New to HTMovie?", style: TextStyle(color: Colors.white54)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePassPage> {
  // xử lý ẩn hiện mật khẩu
  bool _obscurePassword = true; // cũ
  bool _obscureRepeatPassword = true; // mới
  bool _obscureConfirmPassword = true; // confirm mới

  final currentPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallPhone = size.height < 700;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      appBar: AppBar(
        title: Text(
          "Security",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Color(0xFF191022),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: isTablet ? 20 : 12),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: isSmallPhone ? 16 : 24,
            ),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: isSmallPhone ? 50 : 60,),
                  _buildLabel("Current Password"),
                  SizedBox(height: 6),
                  _buildTextField(
                    controller: currentPass,
                    hintText: 'Enter current password',
                    isPassword: true,
                    icon: Icons.lock_outlined,
                    isObscured: _obscurePassword,
                    onToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  SizedBox(height: isSmallPhone ? 15 : 20),
                  _buildLabel("New Password"),
                  SizedBox(height: 6),
                  _buildTextField(
                    controller: newPass,
                    hintText: 'Enter new password',
                    isPassword: true,
                    icon: Icons.vpn_key_outlined,
                    isObscured: _obscureRepeatPassword,
                    onToggle: () {
                      setState(() {
                        _obscureRepeatPassword = !_obscureRepeatPassword;
                      });
                    },
                  ),
                  SizedBox(height: isSmallPhone ? 15 : 20),
                  _buildLabel("Confirm New Password"),
                  SizedBox(height: 6),
                  _buildTextField(
                    controller: confirmPass,
                    hintText: 'Re-enter new password',
                    isPassword: true,
                    icon: Icons.check_circle_outline,
                    isObscured: _obscureConfirmPassword,
                    onToggle: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  SizedBox(height: 24),
                  _buildRequirementBox(),
                  SizedBox(height: 30),
                  _buildUpdatePassButton(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //widget build custom
  Widget _buildLabel(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isObscured = false, //biến trạng thái mới
    VoidCallback? onToggle, // xử lý click ẩn hiện pass
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isObscured : false,
      style: TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.white38, size: 20),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    isObscured
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
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

  Widget _buildUpdatePassButton(Size size) {
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
              "Update Password",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

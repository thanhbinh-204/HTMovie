import 'package:flutter/material.dart';
import '../../widget/components/imagepicker_user.dart';

class EditprofileUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditprofileUserState();
}

class _EditprofileUserState extends State<EditprofileUserPage> {
  final _formkey = GlobalKey<FormState>();

  final _usernameVLD = TextEditingController();
  final _emailVLD = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallPhone = size.height < 700;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      appBar: AppBar(
        title: Text(
          "Edit Profile",
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
              key: _formkey,
              child: Column(
                children: [
                  const ImagePickerUser(),
                  SizedBox(height: 6),
                  Text(
                    'Change Photo',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 20),
                  _buildLabel("Username"),
                  SizedBox(height: 6),
                  _buildTextField(
                    controller: _usernameVLD,
                    hintText: "@moviebuff99",
                    icon: Icons.person_2_outlined,
                  ),
                  SizedBox(height: isSmallPhone ? 15 : 20),
                  _buildLabel("Email Adrress"),
                  SizedBox(height: 6),
                  _buildTextField(
                    controller: _emailVLD,
                    hintText: "alex@example.com",
                    icon: Icons.mail_outline,
                  ),
                  SizedBox(height: isSmallPhone ? 30 : 40),
                  _buildSaveChangesButton(size),
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

  Widget _buildSaveChangesButton(Size size) {
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
              "Save Changes",
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

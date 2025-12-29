import 'package:flutter/material.dart';

// 1. Widget Logo dùng chung
class CustomLogo extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomLogo({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90, height: 90,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Color(0xFF9D50FF), Color(0xFF6E48FF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9D50FF).withOpacity(0.5),
                blurRadius: 20, offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset("assets/images/logo.png", color: Colors.white, fit: BoxFit.contain),
        ),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
        if (subtitle != null) ...[
          SizedBox(height: 8,),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              height: 1.5
            ),
          )
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

// 2. Widget Ô nhập liệu dùng chung
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final bool isObscured;
  final VoidCallback? onToggle;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.isObscured = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? isObscured : false,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
            prefixIcon: Icon(icon, color: Colors.white38, size: 20),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.white38, size: 20,
                    ),
                    onPressed: onToggle,
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFF1E2342),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.white12)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF9D50FF))),
          ),
        ),
      ],
    );
  }
}


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF9D50FF), Color(0xFF6E48FF)]),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9D50FF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}


class RedirectLink extends StatelessWidget {
  final String leadingText;
  final String linkText;
  final VoidCallback onTap;

  const RedirectLink({
    super.key,
    required this.leadingText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
  return InkWell( 
    onTap: onTap,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'), 
        children: [
          TextSpan(
            text: "$leadingText ",
            style: const TextStyle(color: Colors.white54),
          ),
          TextSpan(
            text: linkText,
            style: const TextStyle(
              color: Color(0xFF9D50FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
}


class CustomFoget extends StatelessWidget {
  final String titleForget;
  final String subtitleForget;
  const CustomFoget({super.key, required this.titleForget, required this.subtitleForget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90, height: 90,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Color(0xFF9D50FF), Color(0xFF6E48FF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9D50FF).withOpacity(0.5),
                blurRadius: 20, offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset("assets/images/forget.png", color: Colors.white, fit: BoxFit.contain),
        ),
        const SizedBox(height: 16),
        Text(titleForget, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
        if (subtitleForget != null) ...[
          SizedBox(height: 8,),
          Text(
            subtitleForget!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              height: 1.5
            ),
          )
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}
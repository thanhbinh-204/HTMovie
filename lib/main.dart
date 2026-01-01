import 'package:flutter/material.dart';
import 'page/regis_login_page/Register_page.dart';
import 'page/regis_login_page/Login_page.dart';
import 'page/password/forgot_page.dart';
import 'page/home/home_Page.dart';
import 'page/navbar_page/navbar.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  Navbar() ,
    );
  }
}




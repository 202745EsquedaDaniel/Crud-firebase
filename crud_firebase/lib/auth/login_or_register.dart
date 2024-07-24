import 'package:crud_firebase/pages/login_page.dart';
import 'package:crud_firebase/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegiste extends StatefulWidget {
  const LoginOrRegiste({super.key});

  @override
  State<LoginOrRegiste> createState() => _LoginOrRegisteState();
}

class _LoginOrRegisteState extends State<LoginOrRegiste> {
  // Initially, show the login page
  bool showLoginPage = true;

//toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}

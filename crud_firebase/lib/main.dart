import 'package:crud_firebase/auth/auth.dart';
import 'package:crud_firebase/auth/login_or_register.dart';
import 'package:crud_firebase/firebase_options.dart';
import 'package:crud_firebase/pages/home_page.dart';
import 'package:crud_firebase/pages/login_page.dart';
import 'package:crud_firebase/pages/profile_page.dart';
import 'package:crud_firebase/pages/register_page.dart';
import 'package:crud_firebase/pages/users_page.dart';
import 'package:crud_firebase/theme/dark_mode.dart';
import 'package:crud_firebase/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        "/login_register_page": (context) => const LoginOrRegiste(),
        "/home_page": (context) => const HomePage(),
        "/profile_page": (context) => const ProfilePage(),
        "/users_page": (context) => const UsersPage()
      },
    );
  }
}

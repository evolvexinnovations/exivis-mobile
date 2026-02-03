import 'package:flutter/material.dart';
import 'screens/login_signup_screen.dart'; // Import your login/signup screen

void main() {
  runApp(const ExivisApp());
}

class ExivisApp extends StatelessWidget {
  const ExivisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exivis',
      theme: ThemeData.dark(), // Optional dark theme
      home: const LoginScreen(), // Start directly with LoginScreen
    );
  }
}

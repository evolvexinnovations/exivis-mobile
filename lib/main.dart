import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/landing_screen.dart';

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

      // 👇 FIRST SCREEN (Login)
      home: const LoginScreen(),

      // 👇 Routes for navigation
      routes: {
        '/home': (context) => const HomeScreen(),
        '/landing': (context) => const LandingScreen(),
      },
    );
  }
}

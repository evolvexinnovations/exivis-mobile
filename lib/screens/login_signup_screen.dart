import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'landing_screen.dart'; // LandingScreen import

/* ---------------- LOGIN SCREEN ---------------- */
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ✅ Full API base URL
  static const String baseUrl = 'https://api.exivis.pro/api/auth';

  Future<void> loginUser() async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Login successful")),
        );

        // ✅ Navigate to LandingScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ExivisLandingPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Login failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error connecting to server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width > 600
        ? 400
        : MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      body: backgroundContainer(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset("assets/images/exivis_logo.png", height: 120),
                const SizedBox(height: 30),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                inputField("Email", fieldWidth,
                    controller: emailController, required: true),
                const SizedBox(height: 16),
                passwordField(
                  "Password",
                  fieldWidth,
                  _hidePassword,
                  () => setState(() => _hidePassword = !_hidePassword),
                  controller: passwordController,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: fieldWidth,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF60A5FA),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                primaryButton("Login", loginUser, whiteText: true),
                const SizedBox(height: 20),
                const Text("OR", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                googleButton(fieldWidth),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------- SIGNUP SCREEN ---------------- */
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static const String baseUrl = 'https://api.exivis.pro/api/auth';

  Future<void> signupUser() async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(res.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"] ?? "Signup success")),
      );

      if (res.statusCode == 200) {
        Navigator.pop(context); // back to login
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error connecting to server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width > 600
        ? 400
        : MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      body: backgroundContainer(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset("assets/images/exivis_logo.png", height: 100),
                const SizedBox(height: 24),
                inputField("Username", fieldWidth,
                    controller: usernameController, required: true),
                const SizedBox(height: 16),
                inputField("Email", fieldWidth,
                    controller: emailController, required: true),
                const SizedBox(height: 16),
                passwordField(
                  "Password",
                  fieldWidth,
                  _hidePassword,
                  () => setState(() => _hidePassword = !_hidePassword),
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                passwordField(
                  "Confirm Password",
                  fieldWidth,
                  _hideConfirmPassword,
                  () => setState(
                      () => _hideConfirmPassword = !_hideConfirmPassword),
                ),
                const SizedBox(height: 30),
                primaryButton("Create Account", signupUser, whiteText: true),
                const SizedBox(height: 20),
                googleButton(fieldWidth),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ",
                        style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xFF60A5FA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------- UI HELPERS ---------------- */
Widget backgroundContainer({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0B1C3D),
          Color(0xFF0A1630),
          Color(0xFF070E1F),
        ],
      ),
    ),
    child: child,
  );
}

Widget inputField(String label, double width,
    {TextEditingController? controller, bool required = false}) {
  return SizedBox(
    width: width,
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: inputDecoration(label, required),
    ),
  );
}

Widget passwordField(
    String label, double width, bool obscure, VoidCallback toggle,
    {TextEditingController? controller}) {
  return SizedBox(
    width: width,
    child: TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: inputDecoration(label, true).copyWith(
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey),
          onPressed: toggle,
        ),
      ),
    ),
  );
}

InputDecoration inputDecoration(String label, bool required) {
  return InputDecoration(
    label: RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(color: Colors.grey),
        children: required
            ? const [
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ]
            : [],
      ),
    ),
    filled: true,
    fillColor: const Color(0xFF0F244A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

Widget primaryButton(String text, VoidCallback onPressed,
    {bool whiteText = false}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2563EB),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
          color: whiteText ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600),
    ),
  );
}

Widget googleButton(double width) {
  return SizedBox(
    width: width,
    height: 48,
    child: OutlinedButton(
      onPressed: () {},
      child: const Text("Continue with Google",
          style: TextStyle(color: Colors.white)),
    ),
  );
}

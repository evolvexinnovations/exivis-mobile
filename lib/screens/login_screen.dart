import 'package:flutter/material.dart';

void main() {
  runApp(const ExivisApp());
}

class ExivisApp extends StatelessWidget {
  const ExivisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

/* ---------------- LOGIN SCREEN ---------------- */

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;

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
                inputField("Email", fieldWidth, required: true),
                const SizedBox(height: 16),
                passwordField(
                  "Password",
                  fieldWidth,
                  _hidePassword,
                  () => setState(() => _hidePassword = !_hidePassword),
                ),
                const SizedBox(height: 8),
                // Forgot Password
                SizedBox(
                  width: fieldWidth,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ResetPasswordScreen()),
                        );
                      },
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
                primaryButton("Login", () {}, whiteText: true),
                const SizedBox(height: 20),
                const Text("OR", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                googleButton(fieldWidth),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width > 600
        ? 400
        : MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: backgroundContainer(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset("assets/images/exivis_logo.png", height: 100),
                const SizedBox(height: 24),
                inputField("Username", fieldWidth, required: true),
                const SizedBox(height: 16),
                inputField("Email", fieldWidth, required: true),
                const SizedBox(height: 16),
                passwordField(
                  "Password",
                  fieldWidth,
                  _hidePassword,
                  () => setState(() => _hidePassword = !_hidePassword),
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
                primaryButton("Create Account", () {}, whiteText: true),
                const SizedBox(height: 20),
                const Text("OR", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                googleButton(fieldWidth),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFF60A5FA),
                          fontWeight: FontWeight.w600,
                        ),
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

/* ---------------- RESET PASSWORD SCREEN ---------------- */

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width > 600
        ? 400
        : MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: backgroundContainer(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Enter your email to reset your password",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                inputField("Email", fieldWidth, required: true),
                const SizedBox(height: 30),
                primaryButton(
                  "Send Reset Link",
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Reset link sent to your email")),
                    );
                  },
                  whiteText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------- BACKGROUND ---------------- */

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

/* ---------------- INPUTS ---------------- */

Widget inputField(String label, double width, {bool required = false}) {
  return SizedBox(
    width: width,
    child: TextField(
      style: const TextStyle(color: Colors.white),
      decoration: inputDecoration(label, required),
    ),
  );
}

Widget passwordField(
  String label,
  double width,
  bool obscure,
  VoidCallback toggle,
) {
  return SizedBox(
    width: width,
    child: TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: inputDecoration(label, true).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}

/* ---------------- BUTTONS ---------------- */

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
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget googleButton(double width) {
  return SizedBox(
    width: width,
    height: 48,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "G",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Text(
            "Continue with Google",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

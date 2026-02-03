import 'package:flutter/material.dart';
import 'login_signup_screen.dart';

/// App entry point
void main() {
  runApp(const ExivisApp());
}

class ExivisApp extends StatelessWidget {
  const ExivisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExivisHomePage(),
    );
  }
}

class ExivisHomePage extends StatefulWidget {
  const ExivisHomePage({super.key});

  @override
  State<ExivisHomePage> createState() => _ExivisHomePageState();
}

class _ExivisHomePageState extends State<ExivisHomePage> {
  final TextEditingController _controller = TextEditingController();

  /// Bottom sheet login popup
  void _showLoginPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: const BoxDecoration(
            color: Color(0xFF0F172A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Log in or create an account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your AI workspace for models, visuals and conversations",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),
              const SizedBox(height: 24),

              /// GOOGLE (no action yet)
              _authButton(
                "Continue with Google",
                Colors.white,
                Colors.black,
                icon: const Text(
                  "G",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              const SizedBox(height: 12),

              /// SIGN UP → SignupScreen
              _authButton(
                "Sign up",
                const Color(0xFF1E293B),
                Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignupScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              /// LOG IN → LoginScreen
              _authButton(
                "Log in",
                Colors.transparent,
                Colors.white,
                border: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Auth button
  static Widget _authButton(
    String text,
    Color bgColor,
    Color textColor, {
    bool border = false,
    Widget? icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: border ? Border.all(color: Colors.white24) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSuggestionTap(String text) {
    setState(() {
      _controller.text = text;
    });
  }

  void _onSend() {
    if (_controller.text.trim().isNotEmpty) {
      debugPrint("User input: ${_controller.text}");
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F),
      body: SafeArea(
        child: Column(
          children: [
            /// TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                  const Text(
                    "Exivis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _showLoginPopup(context),
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        color: Color(0xFF0A1A2F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            const Text(
              "What can I help with?",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 24),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SuggestionChip(text: "Brainstorm", onTap: _onSuggestionTap),
                SuggestionChip(text: "Make a plan", onTap: _onSuggestionTap),
                SuggestionChip(text: "Summarize text", onTap: _onSuggestionTap),
                SuggestionChip(text: "More", onTap: _onSuggestionTap),
              ],
            ),

            const Spacer(),

            /// CENTERED & ATTRACTIVE ASK EXIVIS BAR
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132B4A),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x332563EB),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white70),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: "Ask Exivis...",
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _onSend,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Suggestion chip
class SuggestionChip extends StatelessWidget {
  final String text;
  final Function(String) onTap;

  const SuggestionChip({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onTap(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

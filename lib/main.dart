import 'package:flutter/material.dart';

/// App entry point
void main() {
  runApp(const ExivisApp());
}

/// Root widget of the application
class ExivisApp extends StatelessWidget {
  const ExivisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: ExivisLandingPage(), // Load landing page
    );
  }
}

/// Main landing page UI
class ExivisLandingPage extends StatelessWidget {
  const ExivisLandingPage({super.key});

  /// Shows a SnackBar message on user interaction
  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /// ================= LEFT SIDEBAR =================
          Container(
            width: 260, // Fixed sidebar width
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0A1A2F), // Dark blue top
                  Color(0xFF040B17), // Darker bottom
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// App logo / title
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "exivis",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// New Chat button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton.icon(
                      onPressed: () => _showSnack(context, "New Chat clicked"),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        "New Chat",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Sidebar menu items
                  _sideItem(context, icon: Icons.search, label: "Search chats"),
                  _sideItem(context, icon: Icons.image, label: "Images"),
                  _sideItem(context,
                      icon: Icons.folder_open, label: "Projects"),

                  const Spacer(),

                  /// App version info
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "V1.0 · EXIVIS",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= MAIN CONTENT AREA =================
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A1A2F),
                    Color(0xFF040B17),
                  ],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    /// Main column layout
                    Column(
                      children: [
                        /// Top-right action icons
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () =>
                                    _showSnack(context, "Try Go clicked"),
                                child: _pillButton(),
                              ),
                              const SizedBox(width: 16),
                              _circleIcon(
                                context,
                                Icons.person_add,
                                "Add Person clicked",
                              ),
                              const SizedBox(width: 10),
                              _circleIcon(
                                context,
                                Icons.chat_bubble_outline,
                                "Chat clicked",
                              ),
                            ],
                          ),
                        ),

                        /// Center content (Ask Exivis + actions)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Ask Exivis",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 28),

                              /// Feature action buttons
                              Wrap(
                                spacing: 14,
                                runSpacing: 14,
                                alignment: WrapAlignment.center,
                                children: [
                                  ActionButton(
                                    icon: Icons.image,
                                    label: "Create image",
                                    iconColor: Colors.greenAccent,
                                  ),
                                  ActionButton(
                                    icon: Icons.article,
                                    label: "Summarize text",
                                    iconColor: Colors.orangeAccent,
                                  ),
                                  ActionButton(
                                    icon: Icons.edit,
                                    label: "Help me write",
                                    iconColor: Colors.purpleAccent,
                                  ),
                                  ActionButton(
                                    icon: Icons.more_horiz,
                                    label: "More",
                                    iconColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// ================= INPUT BAR =================
                    Positioned(
                      bottom: 90,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 360,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.add, color: Colors.white70),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Ask Exivis...",
                                    hintStyle: TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Icon(Icons.mic, color: Colors.white70),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_upward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sidebar menu item widget
  Widget _sideItem(BuildContext context,
      {required IconData icon, required String label}) {
    return InkWell(
      onTap: () => _showSnack(context, "$label clicked"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  /// Circular icon button (top-right)
  Widget _circleIcon(BuildContext context, IconData icon, String message) {
    return InkWell(
      onTap: () => _showSnack(context, message),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white.withOpacity(0.08),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  /// "Try Go" pill-shaped button
  Widget _pillButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(Icons.auto_awesome, color: Colors.purpleAccent, size: 18),
          SizedBox(width: 6),
          Text("Try Go", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

/// Reusable action button widget
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$label clicked")));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

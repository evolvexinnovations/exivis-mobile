import 'package:flutter/material.dart';

void main() {
  runApp(const ExivisApp());
}

/// ================= APP =================
class ExivisApp extends StatelessWidget {
  const ExivisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExivisLandingPage(),
    );
  }
}

/// ================= MORE MENU ENUM =================
enum MoreMenuAction {
  explainCode,
  debugCode,
  translate,
  uploadFile,
  chatHistory,
  settings,
}

/// ================= LANDING PAGE =================
class ExivisLandingPage extends StatelessWidget {
  const ExivisLandingPage({super.key});

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
            width: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0A1A2F), Color(0xFF040B17)],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NewChatScreen()),
                        );
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        "New Chat",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sideItem(context, Icons.search, "Search chats"),
                  _sideItem(context, Icons.image, "Images"),
                  _sideItem(context, Icons.folder_open, "Projects"),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "V1.0 · Exivis",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= MAIN AREA =================
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0A1A2F), Color(0xFF040B17)],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
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
                                  context, Icons.person_add, "Add Person"),
                              const SizedBox(width: 10),
                              _circleIcon(
                                  context, Icons.chat_bubble_outline, "Chat"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.45),
                                blurRadius: 30,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/exivis_logo.png",
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Exivis",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 26),

                        /// ================= ACTION BUTTONS =================
                        Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          alignment: WrapAlignment.center,
                          children: [
                            InkWell(
                              onTap: () =>
                                  _showSnack(context, "Create image clicked"),
                              child: const ActionButton(
                                icon: Icons.image,
                                label: "Create image",
                                iconColor: Colors.greenAccent,
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  _showSnack(context, "Summarize text clicked"),
                              child: const ActionButton(
                                icon: Icons.article,
                                label: "Summarize text",
                                iconColor: Colors.orangeAccent,
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  _showSnack(context, "Help me write clicked"),
                              child: const ActionButton(
                                icon: Icons.edit,
                                label: "Help me write",
                                iconColor: Colors.purpleAccent,
                              ),
                            ),

                            /// ===== MORE BUTTON (NO InkWell) =====
                            PopupMenuButton<MoreMenuAction>(
                              color: const Color(0xFF0A1A2F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onSelected: (value) {
                                _showSnack(context, "${value.name} clicked");
                              },
                              itemBuilder: (context) => [
                                _moreItem(MoreMenuAction.explainCode,
                                    Icons.code, "Explain Code"),
                                _moreItem(MoreMenuAction.debugCode,
                                    Icons.bug_report, "Debug Code"),
                                _moreItem(MoreMenuAction.translate,
                                    Icons.translate, "Translate"),
                                _moreItem(MoreMenuAction.uploadFile,
                                    Icons.upload_file, "Upload File"),
                                const PopupMenuDivider(),
                                _moreItem(MoreMenuAction.chatHistory,
                                    Icons.history, "Chat History"),
                                _moreItem(MoreMenuAction.settings,
                                    Icons.settings, "Settings"),
                              ],
                              child: const ActionButton(
                                icon: Icons.more_horiz,
                                label: "More",
                                iconColor: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),

                    /// ================= ASK EXIVIS BAR =================
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
                            children: [
                              InkWell(
                                onTap: () => _showSnack(context, "Add clicked"),
                                child: const Icon(Icons.add,
                                    color: Colors.white70),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Ask Exivis...",
                                    hintStyle: TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => _showSnack(context, "Mic clicked"),
                                child: const Icon(Icons.mic,
                                    color: Colors.white70),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () =>
                                    _showSnack(context, "Send clicked"),
                                child: const Icon(Icons.arrow_upward,
                                    color: Colors.white),
                              ),
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

  /// ================= HELPERS =================
  Widget _sideItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () => _showSnack(context, "$label clicked"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 14),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 15)),
          ],
        ),
      ),
    );
  }

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

  Widget _pillButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.auto_awesome, color: Colors.purpleAccent, size: 18),
          SizedBox(width: 6),
          Text("Try Go", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  static PopupMenuItem<MoreMenuAction> _moreItem(
    MoreMenuAction value,
    IconData icon,
    String text,
  ) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.white70),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

/// ================= NEW CHAT SCREEN =================
class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 PUSH HEADER DOWN FROM TOP
            const SizedBox(height: 32),

            /// 🔹 HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    "Exivis",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            /// 🔹 GAP BETWEEN HEADER & CENTER CONTENT (KEY FIX)
            const SizedBox(height: 60), // 👈 THIS creates breathing space

            /// 🔹 CENTER CONTENT
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "What’s today’s agenda?",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    width: 420,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => _snack(context, "Add clicked"),
                          child:
                              const Icon(Icons.add, color: Colors.blueAccent),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Ask Exivis...",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _snack(context, "Mic clicked"),
                          child: const Icon(Icons.mic, color: Colors.white70),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => _snack(context, "Send clicked"),
                          child: const Icon(Icons.arrow_upward,
                              color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= ACTION BUTTON =================
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
    return Container(
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
    );
  }
}

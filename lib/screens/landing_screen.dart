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
class ExivisLandingPage extends StatefulWidget {
  const ExivisLandingPage({super.key});

  @override
  State<ExivisLandingPage> createState() => _ExivisLandingPageState();
}

class _ExivisLandingPageState extends State<ExivisLandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _sidebarController = ScrollController();

  void _snack(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final isMobile = c.maxWidth < 800;

      return Scaffold(
        key: _scaffoldKey,
        drawer: isMobile ? Drawer(child: _sidebar(true)) : null,
        body: Row(
          children: [
            if (!isMobile) _sidebar(false),
            Expanded(child: _mainArea(isMobile)),
          ],
        ),
      );
    });
  }

  /// ================= SIDEBAR =================
  Widget _sidebar(bool isDrawer) {
    return Container(
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
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  if (isDrawer) Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewChatScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("New Chat"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 46),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Scrollbar(
                controller: _sidebarController,
                thumbVisibility: true,
                child: ListView(
                  controller: _sidebarController,
                  children: [
                    _side(Icons.search, "Search chats"),
                    _side(Icons.image, "Images"),
                    _side(Icons.folder_open, "Projects"),
                    const Divider(color: Colors.white24),
                    for (int i = 1; i <= 20; i++) _side(Icons.chat, "Chat $i"),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text("V1.0 · Exivis",
                  style: TextStyle(color: Colors.white54)),
            )
          ],
        ),
      ),
    );
  }

  /// ================= MAIN AREA =================
  Widget _mainArea(bool isMobile) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A1A2F), Color(0xFF040B17)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  if (isMobile)
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                    ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.group, color: Colors.white70),
                    onPressed: () => _snack("Group clicked"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline,
                        color: Colors.white70),
                    onPressed: () => _snack("New chat clicked"),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SubscriptionScreen()),
                    ),
                    child: _pill(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset("assets/images/exivis_logo.png",
                        height: isMobile ? 80 : 100),
                    const SizedBox(height: 10),
                    const Text("Exivis",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      children: [
                        _action("Create image", Icons.image, Colors.green),
                        _action("Summarize text", Icons.article, Colors.orange),
                        _action("Help me write", Icons.edit, Colors.purple),
                        _moreMenu(),
                      ],
                    ),
                    const SizedBox(height: 40),
                    _askBar(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _side(IconData i, String t) {
    return ListTile(
      leading: Icon(i, color: Colors.white70),
      title: Text(t, style: const TextStyle(color: Colors.white70)),
      onTap: () => _snack("$t clicked"),
    );
  }

  Widget _pill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(children: [
        Icon(Icons.auto_awesome, color: Colors.purpleAccent, size: 16),
        SizedBox(width: 6),
        Text("Try Go", style: TextStyle(color: Colors.white)),
      ]),
    );
  }

  Widget _action(String l, IconData i, Color c) {
    return InkWell(
      onTap: () => _snack("$l clicked"),
      child: ActionButton(icon: i, label: l, iconColor: c),
    );
  }

  Widget _moreMenu() {
    return PopupMenuButton<MoreMenuAction>(
      color: const Color(0xFF0A1A2F),
      onSelected: (v) => _snack(v.name),
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: MoreMenuAction.explainCode,
          child: Text("Explain Code", style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          value: MoreMenuAction.debugCode,
          child: Text("Debug Code", style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          value: MoreMenuAction.translate,
          child: Text("Translate", style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          value: MoreMenuAction.uploadFile,
          child: Text("Upload File", style: TextStyle(color: Colors.white)),
        ),
      ],
      child: const ActionButton(
        icon: Icons.more_horiz,
        label: "More",
        iconColor: Colors.blueGrey,
      ),
    );
  }

  Widget _askBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.12),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Row(children: [
          Icon(Icons.add, color: Colors.blueAccent),
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
          SizedBox(width: 6),
          Icon(Icons.arrow_upward, color: Colors.blueAccent),
        ]),
      ),
    );
  }
}

/// ================= ACTION BUTTON =================
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const ActionButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ]),
    );
  }
}

/// ================= NEW CHAT =================
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
            const SizedBox(height: 32),
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
            const SizedBox(height: 60),
            Expanded(
              child: Column(
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

/// ================= SUBSCRIPTION (FIXED) ================

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> plans = [
    {
      "title": "Free",
      "price": "₹0",
      "features": [
        "10 Prompts per day",
        "1 Image Generation",
        "Basic AI Access"
      ],
      "tag": ""
    },
    {
      "title": "Basic",
      "price": "₹499 / month",
      "features": [
        "100 Prompts per day",
        "5 Image Generations",
        "Standard AI Models",
        "Email Support"
      ],
      "tag": "POPULAR"
    },
    {
      "title": "Pro",
      "price": "₹1499 / month",
      "features": [
        "Unlimited Prompts",
        "10 Image Generations",
        "Advanced AI Models",
        "Priority Support"
      ],
      "tag": "BEST VALUE"
    },
    {
      "title": "Enterprise",
      "price": "₹1999 / month",
      "features": [
        "Unlimited Everything",
        "Team Access",
        "Dedicated Manager",
        "Fastest Response"
      ],
      "tag": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040B17),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Choose Your Plan",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            /// PLANS LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  final bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : const LinearGradient(
                                colors: [Color(0xFF0A1A2F), Color(0xFF071224)],
                              ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE + PRICE + TAG
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                plan["title"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (plan["tag"] != "")
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    plan["tag"],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                )
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(
                            plan["price"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),

                          const SizedBox(height: 14),

                          /// FEATURES
                          ...plan["features"].map<Widget>((feature) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.greenAccent, size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// PURCHASE BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  final selectedPlan = plans[selectedIndex]["title"];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selected $selectedPlan plan")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Continue to Purchase",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

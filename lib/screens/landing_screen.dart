import 'package:flutter/material.dart';
import 'new_chat.dart';
import 'subscription.dart';

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
  final TextEditingController _searchController = TextEditingController();

  List<String> allChats = List.generate(20, (i) => "Chat ${i + 1}");
  List<String> filteredChats = [];

  @override
  void initState() {
    super.initState();
    filteredChats = allChats;
  }

  void _searchChats(String query) {
    setState(() {
      filteredChats = allChats
          .where((chat) => chat.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _handleMoreMenu(MoreMenuAction action) {
    _snack(action.name);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 800;

      return ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
          thickness: MaterialStateProperty.all(6),
          radius: const Radius.circular(20),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: isMobile ? Drawer(child: _sidebar(true)) : null,
          body: Row(
            children: [
              if (!isMobile) _sidebar(false),
              Expanded(child: _mainArea(isMobile)),
            ],
          ),
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
          colors: [Color(0xFF0A1A2F), Color(0xFF040B17)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// NEW CHAT BUTTON
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
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 46),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: _searchController,
                onChanged: _searchChats,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search chats...",
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.08),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// CHAT LIST + SCROLLBAR
            Expanded(
              child: Scrollbar(
                controller: _sidebarController,
                thumbVisibility: true,
                child: ListView(
                  controller: _sidebarController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _side(Icons.image, "Images"),
                    _side(Icons.folder_open, "Projects"),
                    const Divider(color: Colors.white24),
                    for (var chat in filteredChats) _side(Icons.chat, chat),
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
          colors: [Color(0xFF0A1A2F), Color(0xFF040B17)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            /// TOP BAR
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SubscriptionScreen()),
                      );
                    },
                    child: _pill(),
                  ),
                ],
              ),
            ),

            /// BODY
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset("assets/images/exivis_logo.png", height: 90),
                    const SizedBox(height: 10),
                    const Text(
                      "Exivis",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// ACTION BUTTONS
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

  /// ================= SIDEBAR ITEM =================
  Widget _side(IconData icon, String title) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () => _snack("$title clicked"),
    );
  }

  /// ================= TRY GO BUTTON =================
  Widget _pill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: Colors.purpleAccent, size: 16),
          SizedBox(width: 6),
          Text("Try Go", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  /// ================= ACTION BUTTON =================
  Widget _action(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () => _snack("$label clicked"),
      child: ActionButton(icon: icon, label: label, iconColor: color),
    );
  }

  /// ================= MORE MENU =================
  Widget _moreMenu() {
    return PopupMenuButton<MoreMenuAction>(
      color: const Color(0xFF0A1A2F),
      onSelected: _handleMoreMenu,
      itemBuilder: (_) => MoreMenuAction.values
          .map((e) => PopupMenuItem(
                value: e,
                child: Text(
                  e.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
          .toList(),
      child: const ActionButton(
        icon: Icons.more_horiz,
        label: "More",
        iconColor: Colors.blueGrey,
      ),
    );
  }

  /// ================= ASK BAR =================
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
        child: Row(
          children: [
            InkWell(
              onTap: () => _snack("Add clicked"),
              child: const Icon(Icons.add, color: Colors.blueAccent),
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
              onTap: () => _snack("Mic clicked"),
              child: const Icon(Icons.mic, color: Colors.white70),
            ),
            const SizedBox(width: 6),
            InkWell(
              onTap: () => _snack("Send clicked"),
              child: const Icon(Icons.arrow_upward, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= ACTION BUTTON WIDGET =================
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

import 'package:flutter/material.dart';

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

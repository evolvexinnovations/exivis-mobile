import 'package:flutter/material.dart';

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
            /// ---------- HEADER ----------
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// ---------- PLAN LIST ----------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  final bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
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
                          /// Title + Tag
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                plan["title"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                )
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// Price
                          Text(
                            plan["price"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 14),

                          /// Features
                          ...List.generate(
                            plan["features"].length,
                            (i) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.greenAccent,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      plan["features"][i],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// ---------- PURCHASE BUTTON ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  final selectedPlan = plans[selectedIndex]["title"];

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Selected $selectedPlan plan"),
                    ),
                  );

                  /// 👉 Later you can connect Payment Gateway here
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

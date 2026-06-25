import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class Knowledges extends StatelessWidget {
  const Knowledges({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Obx(() {
      final skills = controller.skills;
      if (skills.isEmpty) return const SizedBox.shrink();

      // Group skills for Knowledge section (e.g., categories like IT, Security, Version Control)
      final knowledgeSkills = skills.where((s) => 
        s.category.toLowerCase().contains('control') || 
        s.category.toLowerCase().contains('it') ||
        s.category.toLowerCase().contains('security') ||
        s.category.toLowerCase().contains('iot')
      ).toList();

      if (knowledgeSkills.isEmpty) {
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.white12, height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Expertise',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            ExpertiseCard(name: 'Arduino', category: 'IoT'),
            ExpertiseCard(name: 'Git', category: 'Version Control'),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.white12, height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Expertise',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          ...knowledgeSkills.map((s) => ExpertiseCard(name: s.name, category: s.category)),
        ],
      );
    });
  }
}

class ExpertiseCard extends StatelessWidget {
  final String name;
  final String category;

  const ExpertiseCard({super.key, required this.name, required this.category});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color accentColor;

    final cat = category.toLowerCase();
    if (cat.contains('iot')) {
      icon = Icons.developer_board_rounded;
      accentColor = Colors.orangeAccent;
    } else if (cat.contains('control') || cat.contains('git')) {
      icon = Icons.commit_rounded;
      accentColor = Colors.greenAccent;
    } else if (cat.contains('security') || cat.contains('cyber')) {
      icon = Icons.shield_rounded;
      accentColor = Colors.redAccent;
    } else {
      // Default / IT / Networking
      icon = Icons.lan_rounded;
      accentColor = Colors.cyanAccent;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left accent line
                Container(
                  width: 3.5,
                  color: accentColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        // Category Icon
                        Icon(
                          icon,
                          size: 14,
                          color: accentColor,
                        ),
                        const SizedBox(width: 10),
                        // Title
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        // Category Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: accentColor.withValues(alpha: 0.25),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            category.toUpperCase(),
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

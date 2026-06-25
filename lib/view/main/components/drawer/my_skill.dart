import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  const AnimatedLinearProgressIndicator(
      {super.key, required this.percentage, required this.title, this.image});
  final double percentage;
  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: percentage),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              image!,
                              height: 16,
                              width: 16,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.code_rounded, size: 16, color: Colors.white38),
                            ),
                          )
                        : const Icon(Icons.code_rounded, size: 16, color: Colors.white38),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${(value * 100).toInt()}%',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 3,
                            child: LinearProgressIndicator(
                              value: value,
                              backgroundColor: Colors.white.withValues(alpha: 0.05),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MySKills extends StatelessWidget {
  const MySKills({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Obx(() {
      if (controller.isSkillsLoading.value && controller.skills.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      
      final skills = controller.skills;
      
      if (skills.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skills.map((skill) {
          // Provide a fallback percentage if proficiency is not out of 100
          // The SkillModel says proficiency is 1-5 scale, so percentage = proficiency / 5.0
          double percentage = (skill.proficiency / 5.0).clamp(0.0, 1.0);
          return AnimatedLinearProgressIndicator(
            percentage: percentage,
            title: skill.name,
            image: _getAssetForSkill(skill.name),
          );
        }).toList(),
      );
    });
  }

  String? _getAssetForSkill(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('mern')) return 'assets/icons/MERN-logo.png';
    if (lower.contains('flutter')) return 'assets/icons/flutter.png';
    if (lower.contains('dart')) return 'assets/icons/dart.png';
    if (lower.contains('firebase')) return 'assets/icons/firebase.png';
    if (lower.contains('bloc')) return 'assets/icons/bloc.png';
    return null;
  }
}

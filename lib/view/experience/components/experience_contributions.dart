import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

/// Numbered contribution bullet list
class ExperienceContributions extends StatelessWidget {
  final List<String> responsibilities;
  final Color accent;

  const ExperienceContributions({super.key, required this.responsibilities, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: accent.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6)),
            child: Text('KEY CONTRIBUTIONS',
                style: TextStyle(color: accent.withValues(alpha: 0.9), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: responsibilities.take(4).toList().asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [accent.withValues(alpha: 0.7), accent.withValues(alpha: 0.3)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text('${entry.key + 1}',
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(entry.value,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: AppConstants.bodyTextColor, fontSize: 12, height: 1.45)),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

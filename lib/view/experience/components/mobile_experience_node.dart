import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/constants.dart';
import 'experience_details.dart';

class MobileExperienceNode extends StatelessWidget {
  final Color accent;
  final bool isHovered;
  final int index;
  final String yearText;
  final int totalCount;
  final ValueChanged<bool> onHover;

  const MobileExperienceNode({
    super.key,
    required this.accent,
    required this.isHovered,
    required this.index,
    required this.yearText,
    required this.totalCount,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 22.75,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: isHovered ? 0.6 : 0.25),
                  index == totalCount - 1 ? Colors.transparent : accent.withValues(alpha: 0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [accent.withValues(alpha: isHovered ? 0.3 : 0.1), Colors.transparent],
                        ),
                      ),
                    )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.15, 1.15), duration: const Duration(milliseconds: 1600)),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [accent, accent.withValues(alpha: 0.5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [BoxShadow(color: accent.withValues(alpha: isHovered ? 0.5 : 0.2), blurRadius: 14)],
                      ),
                      child: const Center(child: Icon(Icons.work_history_rounded, color: Colors.white, size: 15)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.spacing32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            accent.withValues(alpha: isHovered ? 0.18 : 0.08),
                            const Color(0xFF07111F).withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isHovered ? accent : accent.withValues(alpha: 0.3), width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: isHovered ? accent.withValues(alpha: 0.25) : accent.withValues(alpha: 0.05),
                            blurRadius: isHovered ? 10 : 4,
                          ),
                        ],
                      ),
                      child: Text(yearText,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                    ),
                    const SizedBox(height: 8),
                    ExperienceStack(index: index, onHover: onHover)
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOutExpo),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

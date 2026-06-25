import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExperienceHolographicNode extends StatelessWidget {
  final Color accent;
  final bool isHovered;
  final int index;
  final String label;

  const ExperienceHolographicNode({
    super.key,
    required this.accent,
    required this.isHovered,
    required this.index,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                accent.withValues(alpha: isHovered ? 0.3 : 0.1),
                Colors.transparent,
              ],
            ),
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1.15, 1.15),
                duration: const Duration(milliseconds: 1600)),

        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: accent.withValues(alpha: isHovered ? 0.7 : 0.2),
              width: 1.5,
            ),
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .rotate(duration: const Duration(seconds: 8)),

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
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: isHovered ? 0.5 : 0.2),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.work_history_rounded,
                color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }
}

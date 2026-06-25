import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EducationHolographicNode extends StatelessWidget {
  final Color nodeColor;
  final bool isHovered;

  const EducationHolographicNode({
    super.key,
    required this.nodeColor,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                nodeColor.withValues(alpha: isHovered ? 0.35 : 0.15),
                Colors.transparent
              ],
            ),
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
            begin: const Offset(0.85, 0.85),
            end: const Offset(1.15, 1.15),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut),
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: nodeColor.withValues(alpha: isHovered ? 0.8 : 0.25),
                width: 1.5),
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .rotate(duration: const Duration(seconds: 8)),
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [nodeColor, nodeColor.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                  color: nodeColor.withValues(alpha: isHovered ? 0.5 : 0.2),
                  blurRadius: 15,
                  spreadRadius: 1)
            ],
          ),
          child: const Center(
              child: Icon(Icons.school_rounded, color: Colors.white, size: 18)),
        ),
      ],
    );
  }
}

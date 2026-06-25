import 'package:flutter/material.dart';
export 'mobile_experience_node.dart';
export 'experience_holographic_node.dart';


class ExperienceSpineSegment extends StatelessWidget {
  final Color accent;
  final bool isHovered;
  final bool isFirst;
  final bool isLast;
  final bool topToBottom;

  const ExperienceSpineSegment({
    super.key,
    required this.accent,
    required this.isHovered,
    required this.isFirst,
    required this.isLast,
    required this.topToBottom,
  });

  @override
  Widget build(BuildContext context) {
    final double height = isFirst || isLast ? 32 : 56;
    final Color top = topToBottom
        ? (isFirst ? Colors.transparent : accent.withValues(alpha: isHovered ? 0.7 : 0.25))
        : accent;
    final Color bottom = topToBottom
        ? accent
        : (isLast ? Colors.transparent : accent.withValues(alpha: isHovered ? 0.7 : 0.25));

    return Container(
      width: isHovered ? 3.0 : 2.0,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [top, bottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class ExperienceYearPill extends StatelessWidget {
  final String year;
  final Color accent;
  final bool isHovered;

  const ExperienceYearPill({
    super.key,
    required this.year,
    required this.accent,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: isHovered ? 0.18 : 0.08),
            const Color(0xFF07111F).withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHovered ? accent : accent.withValues(alpha: 0.35),
          width: isHovered ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? accent.withValues(alpha: 0.3)
                : accent.withValues(alpha: 0.08),
            blurRadius: isHovered ? 16 : 8,
            spreadRadius: isHovered ? 1 : 0,
          ),
        ],
      ),
      child: Text(
        year,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontFamily: 'Outfit',
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}


class ExperienceHorizontalConnector extends StatelessWidget {
  final Color accent;
  final bool isHovered;
  final bool rightToLeft;

  const ExperienceHorizontalConnector({
    super.key,
    required this.accent,
    required this.isHovered,
    required this.rightToLeft,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 2,
      width: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHovered
              ? [
                  rightToLeft
                      ? accent
                      : accent.withValues(alpha: 0.1),
                  rightToLeft
                      ? accent.withValues(alpha: 0.1)
                      : accent,
                ]
              : [Colors.white10, Colors.transparent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          if (isHovered)
            BoxShadow(
              color: accent.withValues(alpha: 0.4),
              blurRadius: 8,
            ),
        ],
      ),
    );
  }
}



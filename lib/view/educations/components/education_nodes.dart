import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/constants.dart';
export 'mobile_education_node.dart';
export 'education_holographic_node.dart';

class EducationSpineSegment extends StatelessWidget {
  final Color activeColor;
  final bool isHovered;
  final bool isFirst;
  final bool isLast;
  final bool topToBottom;

  const EducationSpineSegment({
    super.key,
    required this.activeColor,
    required this.isHovered,
    required this.isFirst,
    required this.isLast,
    required this.topToBottom,
  });

  @override
  Widget build(BuildContext context) {
    final double height =
        (isFirst && topToBottom) || (isLast && !topToBottom) ? 30 : 60;

    final Color top = topToBottom
        ? (isFirst
            ? Colors.transparent
            : (isHovered
                ? activeColor.withValues(alpha: 0.8)
                : AppConstants.primaryColor.withValues(alpha: 0.3)))
        : (isHovered ? activeColor : AppConstants.primaryColor);

    final Color bottom = topToBottom
        ? (isHovered ? activeColor : AppConstants.primaryColor)
        : (isLast
            ? Colors.transparent
            : (isHovered
                ? activeColor.withValues(alpha: 0.8)
                : AppConstants.primaryColor.withValues(alpha: 0.3)));

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

class EducationYearPill extends StatelessWidget {
  final String year;
  final Color activeColor;
  final bool isHovered;

  const EducationYearPill({
    super.key,
    required this.year,
    required this.activeColor,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            activeColor.withValues(alpha: isHovered ? 0.18 : 0.08),
            const Color(0xFF07111F).withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHovered ? activeColor : activeColor.withValues(alpha: 0.35),
          width: isHovered ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? activeColor.withValues(alpha: 0.3)
                : activeColor.withValues(alpha: 0.08),
            blurRadius: isHovered ? 16 : 8,
            spreadRadius: isHovered ? 1 : 0,
          )
        ],
      ),
      child: Text(
        year,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          fontFamily: 'Outfit',
          letterSpacing: 0.5,
        ),
      ),
    )
        .animate(target: isHovered ? 1.0 : 0.0)
        .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.08, 1.08));
  }
}


class EducationHorizontalConnector extends StatelessWidget {
  final Color activeColor;
  final bool isHovered;
  final bool rightToLeft;

  const EducationHorizontalConnector({
    super.key,
    required this.activeColor,
    required this.isHovered,
    required this.rightToLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHovered
              ? (rightToLeft
                  ? [activeColor, activeColor.withValues(alpha: 0.1)]
                  : [activeColor.withValues(alpha: 0.1), activeColor])
              : (rightToLeft
                  ? [Colors.white12, Colors.transparent]
                  : [Colors.transparent, Colors.white12]),
          begin: rightToLeft ? Alignment.centerRight : Alignment.centerLeft,
          end: rightToLeft ? Alignment.centerLeft : Alignment.centerRight,
        ),
        boxShadow: [
          if (isHovered)
            BoxShadow(
                color: activeColor.withValues(alpha: 0.4),
                blurRadius: 8,
                spreadRadius: 1),
        ],
      ),
    )
        .animate(target: isHovered ? 1.0 : 0.0)
        .scaleXY(begin: 0.8, end: 1.1, curve: Curves.easeInOut);
  }
}

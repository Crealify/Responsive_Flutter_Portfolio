import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

/// A standard horizontal divider used between key sections of the portfolio.
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final double lineWidth = isDesktop ? 400.0 : 180.0;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? AppConstants.spacing64 : AppConstants.spacing32,
        vertical: isDesktop ? 80.0 : 48.0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Premium fading gradient divider line ──
          Container(
            width: lineWidth,
            height: 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyanAccent.withValues(alpha: 0.0),
                  Colors.cyanAccent.withValues(alpha: 0.35),
                  Colors.cyanAccent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          // ── Glowing central cyber-dot ──
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.8),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

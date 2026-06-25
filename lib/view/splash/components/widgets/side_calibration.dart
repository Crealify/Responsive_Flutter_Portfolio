import 'package:flutter/material.dart';

class SideCalibration extends StatelessWidget {
  final Size size;
  final double progress;
  const SideCalibration({super.key, required this.size, required this.progress});

  @override
  Widget build(BuildContext context) {
    if (progress < 0.4) return const SizedBox.shrink();
    final opacity = ((progress - 0.4) / 0.3).clamp(0.0, 1.0);
    final pct = '${(progress * 100).toInt()}%';

    return Opacity(
      opacity: opacity,
      child: Stack(
        children: [
          Positioned(
            left: 32,
            top: 0,
            bottom: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      color: Colors.white.withValues(alpha: 0.1),
                      thickness: 0.8,
                    ),
                  ),
                  const SizedBox(width: 8),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'INITIALIZING  $pct',
                      style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 2,
                        color: Colors.white.withValues(alpha: 0.2),
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 32,
            top: 0,
            bottom: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'AB  PORTFOLIO  2026',
                      style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 2,
                        color: Colors.white.withValues(alpha: 0.2),
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      color: Colors.white.withValues(alpha: 0.1),
                      thickness: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/constants.dart';
import 'precision_progress_bar.dart';
class PrecisionProgress extends StatelessWidget {
  final double progress;
  const PrecisionProgress({super.key, required this.progress});

  String _phase(double v) {
    if (v < 0.20) return 'BOOTING NEURAL SYSTEMS';
    if (v < 0.45) return 'COMPILING CREATIVE ENGINE';
    if (v < 0.70) return 'SYNCHRONIZING PORTFOLIO';
    if (v < 0.90) return 'CALIBRATING INTERFACES';
    return 'SYSTEMS  ONLINE';
  }

  @override
  Widget build(BuildContext context) {
    final pct = (progress * 100).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: progress >= 1.0
                        ? const Color(0xFF22C55E)
                        : AppConstants.activeIconColor,
                    boxShadow: [
                      BoxShadow(
                        color: (progress >= 1.0
                                ? const Color(0xFF22C55E)
                                : AppConstants.activeIconColor)
                            .withValues(alpha: 0.9),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _phase(progress),
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 2.5,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, AppConstants.activeIconColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                '$pct%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Outfit',
                  fontFeatures: [FontFeature.tabularFigures()],
                  letterSpacing: 1,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        PrecisionProgressBar(progress: progress),
        const SizedBox(height: 6),
        LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(21, (i) {
              final isFilled = (i / 20) <= progress;
              final isMajor = i % 5 == 0;
              return Container(
                width: isMajor ? 1.5 : 1,
                height: isMajor ? 7 : 4,
                decoration: BoxDecoration(
                  color: isFilled
                      ? (isMajor
                          ? AppConstants.activeIconColor
                          : AppConstants.activeIconColor.withValues(alpha: 0.7))
                      : Colors.white.withValues(alpha: isMajor ? 0.15 : 0.08),
                  boxShadow: isFilled && isMajor
                      ? [
                          BoxShadow(
                            color: AppConstants.activeIconColor.withValues(alpha: 0.6),
                            blurRadius: 4,
                          )
                        ]
                      : null,
                ),
              );
            }),
          );
        }),
      ],
    )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms);
  }
}

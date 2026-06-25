import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class PrecisionProgressBar extends StatelessWidget {
  final double progress;

  const PrecisionProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: LayoutBuilder(builder: (context, constraints) {
        final filledWidth = constraints.maxWidth * progress;
        final iconLeft = (filledWidth - 11).clamp(0.0, constraints.maxWidth - 22);
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomLeft,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 3,
                width: filledWidth,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppConstants.primaryColor,
                      AppConstants.secondaryColor,
                      AppConstants.activeIconColor,
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.activeIconColor.withValues(alpha: 0.9),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: AppConstants.primaryColor.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              left: iconLeft,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppConstants.activeIconColor.withValues(alpha: 0.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    progress >= 1.0 ? Icons.check_circle_outline : Icons.laptop_mac,
                    color: progress >= 1.0
                        ? const Color(0xFF22C55E)
                        : Colors.white,
                    size: 18,
                    shadows: [
                      Shadow(
                        color: (progress >= 1.0
                                ? const Color(0xFF22C55E)
                                : AppConstants.activeIconColor)
                            .withValues(alpha: 0.9),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

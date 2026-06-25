import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/constants.dart';
import '../painters/splash_painters.dart';

class CentralOrbit extends StatelessWidget {
  final double progress;
  final double idleAngle;
  const CentralOrbit({super.key, required this.progress, required this.idleAngle});

  @override
  Widget build(BuildContext context) {
    const size = 200.0;
    final logoScale = Curves.easeOutBack.transform(progress.clamp(0.0, 1.0));

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(size, size),
            painter: DashedRingPainter(
              angle: idleAngle * 0.6,
              radius: size / 2 - 2,
              color: AppConstants.primaryColor.withValues(alpha: 0.25 * progress),
              dashCount: 60,
              dashFraction: 0.4,
              strokeWidth: 0.8,
            ),
          ),
          CustomPaint(
            size: const Size(size - 18, size - 18),
            painter: ArcProgressRingPainter(
              progress: progress,
              angle: idleAngle,
            ),
          ),
          CustomPaint(
            size: const Size(size - 44, size - 44),
            painter: DashedRingPainter(
              angle: -idleAngle * 1.8,
              radius: (size - 44) / 2 - 1,
              color: AppConstants.activeIconColor.withValues(alpha: 0.4 * progress),
              dashCount: 24,
              dashFraction: 0.3,
              strokeWidth: 1.2,
            ),
          ),
          Transform.scale(
            scale: logoScale,
            child: Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppConstants.primaryColor.withValues(alpha: 0.35),
                    AppConstants.bgColor.withValues(alpha: 0.95),
                  ],
                  stops: const [0.0, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.primaryColor.withValues(alpha: 0.55 * progress),
                    blurRadius: 28,
                    spreadRadius: 3,
                  ),
                  BoxShadow(
                    color: AppConstants.activeIconColor.withValues(alpha: 0.3 * progress),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/icons/portfolio_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .scale(begin: const Offset(0.6, 0.6), duration: 700.ms, curve: Curves.easeOutBack);
  }
}

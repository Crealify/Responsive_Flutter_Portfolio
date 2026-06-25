import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../res/components/premium_3d_tilt.dart';

class AnimatedImageContainer extends StatelessWidget {
  const AnimatedImageContainer(
      {super.key, this.height = 320, this.width = 320});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // Ensure it's a perfect circle by taking the min of width/height
    final size = (width != null && height != null)
        ? (width! < height! ? width! : height!)
        : 320.0;

    return RepaintBoundary(
      child: Premium3DTilt(
        maxTiltX: 0.15,
        maxTiltY: 0.15,
        depth: 10.0,
        scale: 1.05,
        child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Rotating Cyber Ring
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF06B6D4).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: const CircularProgressIndicator(
                value: 0.8,
                strokeWidth: 2,
                color: Color(0xFF06B6D4),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .rotate(duration: 12.seconds, curve: Curves.linear),

            // Inner Counter-Rotating Emerald Dash Ring
            Container(
              width: size * 0.9,
              height: size * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: const CircularProgressIndicator(
                value: 0.4,
                strokeWidth: 3,
                color: Color(0xFF10B981),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).rotate(
                duration: 8.seconds, begin: 1, end: 0, curve: Curves.linear),

            // Glassmorphic Glow Backdrop
            RepaintBoundary(
              child: Container(
                width: size * 0.82,
                height: size * 0.82,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF06B6D4).withValues(alpha: 0.25),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),

            // Actual Profile Avatar
            RepaintBoundary(
              child: ClipOval(
                child: Container(
                  width: size * 0.82,
                  height: size * 0.82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF07111F),
                    border: Border.all(
                      color: const Color(0xFF06B6D4).withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                  children: [
                    // Inner radial glow
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF06B6D4).withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                          radius: 0.8,
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.15,
                      child: Image.asset(
                        'assets/images/anilprofile.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) return child;
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(Icons.person,
                              color: Colors.white54, size: 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    ))
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: -8, end: 8, duration: 3.seconds, curve: Curves.easeInOut);
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class FloatingParticlePainter extends CustomPainter {
  final double t;
  final Size size;
  final double progress;
  static final List<Particle> particles = List.generate(
    28,
    (i) => Particle(seed: i),
  );
  const FloatingParticlePainter(
      {required this.t, required this.size, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final x = (p.baseX * size.width +
              math.sin(t * 2 * math.pi * p.speedX + p.phaseX) * 30) %
          size.width;
      final y = (p.baseY * size.height +
              math.cos(t * 2 * math.pi * p.speedY + p.phaseY) * 20) %
          size.height;
      final alpha = p.alpha * progress;
      canvas.drawCircle(
        Offset(x, y),
        p.radius,
        Paint()
          ..color = p.color.withValues(alpha: alpha)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.radius * 1.5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FloatingParticlePainter old) => old.t != t;
}

class Particle {
  final double baseX, baseY, speedX, speedY, phaseX, phaseY, alpha, radius;
  final Color color;

  Particle({required int seed})
      : baseX = _hash(seed, 0),
        baseY = _hash(seed, 1),
        speedX = 0.05 + _hash(seed, 2) * 0.1,
        speedY = 0.05 + _hash(seed, 3) * 0.1,
        phaseX = _hash(seed, 4) * 2 * math.pi,
        phaseY = _hash(seed, 5) * 2 * math.pi,
        alpha = 0.15 + _hash(seed, 6) * 0.35,
        radius = 0.6 + _hash(seed, 7) * 1.4,
        color = seed % 3 == 0
            ? AppConstants.primaryColor
            : seed % 3 == 1
                ? AppConstants.activeIconColor
                : AppConstants.secondaryColor;

  static double _hash(int seed, int offset) {
    final v = math.sin(seed * 127.1 + offset * 311.7) * 43758.5453;
    return v - v.floor();
  }
}

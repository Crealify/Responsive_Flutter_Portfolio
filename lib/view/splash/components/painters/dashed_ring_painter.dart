import 'dart:math' as math;
import 'package:flutter/material.dart';

class DashedRingPainter extends CustomPainter {
  final double angle;
  final double radius;
  final Color color;
  final int dashCount;
  final double dashFraction;
  final double strokeWidth;
  const DashedRingPainter({
    required this.angle,
    required this.radius,
    required this.color,
    required this.dashCount,
    required this.dashFraction,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final segmentAngle = (2 * math.pi) / dashCount;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < dashCount; i++) {
      final start = angle + i * segmentAngle;
      final sweep = segmentAngle * dashFraction;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DashedRingPainter old) => old.angle != angle;
}

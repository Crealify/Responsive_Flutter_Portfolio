import 'dart:ui';
import 'package:flutter/material.dart';

/// Clean, subtle dot grid painter for the card editor background.
class SubtleDotGridPainter extends CustomPainter {
  const SubtleDotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03) // Extremely faint
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const double spacing = 16.0;
    List<Offset> points = [];
    for (double x = 8; x < w; x += spacing) {
      for (double y = 8; y < h; y += spacing) {
        points.add(Offset(x, y));
      }
    }
    canvas.drawPoints(PointMode.points, points, dotPaint);
  }

  @override
  bool shouldRepaint(covariant SubtleDotGridPainter oldDelegate) => false;
}

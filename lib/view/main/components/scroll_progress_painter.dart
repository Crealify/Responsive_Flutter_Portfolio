import 'package:flutter/material.dart';

/// Draws a premium sweep-gradient progress ring track around custom buttons (e.g. scroll-to-top FAB).
class ScrollProgressPainter extends CustomPainter {
  final double progress;
  const ScrollProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final Paint progressPaint = Paint()
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Premium brand gradient sweep (Cyan -> Blue -> Violet -> Cyan)
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    progressPaint.shader = const SweepGradient(
      colors: [
        Color(0xFF06B6D4), // Cyan
        Color(0xFF3B82F6), // Blue
        Color(0xFF8B5CF6), // Violet
        Color(0xFF06B6D4), // Cyan loop
      ],
      startAngle: -1.570796, // start at top (-pi/2)
      endAngle: 4.712389, // end at 3pi/2
    ).createShader(rect);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 1.25; // adjust for stroke width

    // Draw thin background track circle
    canvas.drawCircle(center, radius, bgPaint);

    // Draw dynamic progress arc
    final double angle = 2 * 3.1415926535 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.570796, // top position (-90 degrees)
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScrollProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

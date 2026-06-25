import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class ArcProgressRingPainter extends CustomPainter {
  final double progress;
  final double angle;
  const ArcProgressRingPainter({required this.progress, required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    const startAngle = -math.pi / 2; // Top

    // Track ring
    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Gradient sweep arc
    final sweepAngle = progress * 2 * math.pi;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final arcPaint = Paint()
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: const [
          AppConstants.primaryColor,
          AppConstants.secondaryColor,
          AppConstants.activeIconColor,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(rect)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);

    // Glowing leading dot at arc tip
    final tipAngle = startAngle + sweepAngle;
    final tipX = center.dx + radius * math.cos(tipAngle);
    final tipY = center.dy + radius * math.sin(tipAngle);
    canvas.drawCircle(
      Offset(tipX, tipY),
      4,
      Paint()
        ..color = AppConstants.activeIconColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(
      Offset(tipX, tipY),
      2,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant ArcProgressRingPainter old) =>
      old.progress != progress || old.angle != angle;
}

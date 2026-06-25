import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class AmbientBackgroundPainter extends CustomPainter {
  final double pulse;
  final double progress;
  const AmbientBackgroundPainter({required this.pulse, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Deep base
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppConstants.bgColor,
    );

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Primary violet bloom
    final violet = Paint()
      ..shader = RadialGradient(
        colors: [
          AppConstants.primaryColor.withValues(alpha: 0.18 * pulse * progress),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(cx, cy), radius: size.width * 0.55));
    canvas.drawCircle(Offset(cx, cy), size.width * 0.55, violet);

    // Offset cyan accent bloom (upper-right)
    final cyan = Paint()
      ..shader = RadialGradient(
        colors: [
          AppConstants.activeIconColor.withValues(alpha: 0.10 * pulse * progress),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(cx * 1.6, cy * 0.4), radius: size.width * 0.35));
    canvas.drawCircle(Offset(cx * 1.6, cy * 0.4), size.width * 0.35, cyan);

    // Deep blue accent (lower-left)
    final blue = Paint()
      ..shader = RadialGradient(
        colors: [
          AppConstants.secondaryColor.withValues(alpha: 0.08 * progress),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(cx * 0.3, cy * 1.7), radius: size.width * 0.3));
    canvas.drawCircle(Offset(cx * 0.3, cy * 1.7), size.width * 0.3, blue);
  }

  @override
  bool shouldRepaint(covariant AmbientBackgroundPainter old) =>
      old.pulse != pulse || old.progress != progress;
}

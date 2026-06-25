import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class HRulePainter extends CustomPainter {
  final double progress;
  final double width;
  const HRulePainter({required this.progress, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress < 0.3) return;
    final reveal = Curves.easeOut.transform(((progress - 0.3) / 0.7).clamp(0.0, 1.0));
    final cx = width / 2;
    final halfLen = cx * reveal;

    // Left arm
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          AppConstants.primaryColor.withValues(alpha: 0.4),
          AppConstants.activeIconColor.withValues(alpha: 0.2),
        ],
        stops: const [0.0, 0.6, 1.0],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ).createShader(Rect.fromLTWH(cx - halfLen, 0, halfLen, 1))
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx - halfLen, 0), Offset(cx, 0), paint);

    // Right arm
    final paintR = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          AppConstants.primaryColor.withValues(alpha: 0.4),
          AppConstants.activeIconColor.withValues(alpha: 0.2),
        ],
        stops: const [0.0, 0.6, 1.0],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(cx, 0, halfLen, 1))
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx, 0), Offset(cx + halfLen, 0), paintR);
  }

  @override
  bool shouldRepaint(covariant HRulePainter old) => old.progress != progress;
}

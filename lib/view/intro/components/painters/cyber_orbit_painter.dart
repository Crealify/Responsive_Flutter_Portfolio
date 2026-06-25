import 'package:flutter/material.dart';

/// Painter for the large glowing cyber orbit circle behind the card.
class CyberOrbitPainter extends CustomPainter {
  const CyberOrbitPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);

    // The exact top-right corner of the glass card in local coordinates
    final Offset cardCorner = const Offset(275, 45);

    // Mathematically calculated radius to pass EXACTLY through the cardCorner:
    // sqrt((275 - 160)^2 + (45 - 160)^2) = 115 * sqrt(2) = 162.6
    final double radius = 162.5;

    // Layer 1: Soft ambient gradient orb (80% transparent/low opacity)
    final Paint orbPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF3B82F6).withValues(alpha: 0.22), // Blue
          const Color(0xFF8B5CF6).withValues(alpha: 0.15), // Purple
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.5));
    canvas.drawCircle(center, radius * 1.3, orbPaint);

    // Layer 2: Ambient Bloom centered EXACTLY at the card's top-right edge (275, 45)
    final Paint cyanBloomPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF06B6D4)
              .withValues(alpha: 0.55), // Enhanced vibrant cyan bloom
          const Color(0xFF3B82F6).withValues(alpha: 0.22), // Blue outer
          const Color(0xFF8B5CF6).withValues(alpha: 0.08), // Violet transition
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 0.75, 1.0],
      ).createShader(Rect.fromCircle(center: cardCorner, radius: 120.0));
    canvas.drawCircle(cardCorner, 120.0, cyanBloomPaint);

    // Layer 3: Ambient Bloom (Large soft blur around the rim)
    final Paint bloomPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0)
      ..shader = const SweepGradient(
        colors: [
          Color(0x1F3B82F6), // Blue 12%
          Color(0x1F8B5CF6), // Purple 12%
          Color(0x1F06B6D4), // Cyan 12%
          Color(0x1F3B82F6),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, bloomPaint);

    // Layer 4: Cyan Edge Rim Light (Vibrant corner highlight)
    final Paint rimLightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.8)
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF06B6D4).withValues(alpha: 0.98), // Vibrant Cyan
          const Color(0xFF3B82F6).withValues(alpha: 0.45), // Blue
          Colors.transparent,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.8, // Start angle (covers intersection area)
      2.0, // Sweep angle (covers top-right quadrant)
      false,
      rimLightPaint,
    );

    // Layer 5: Main Ring Stroke (Thin, semi-transparent purple/cyan gradient)
    final Paint ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = const SweepGradient(
        colors: [
          Color(0x663B82F6), // Blue 40%
          Color(0x668B5CF6), // Purple 40%
          Color(0x4006B6D4), // Cyan 25%
          Color(0x663B82F6),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, ringPaint);

    // Extra Layer: Fading arc to close the circle with extreme subtlety
    final Paint subtleRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFF8B5CF6).withValues(alpha: 0.18),
          const Color(0xFF3B82F6).withValues(alpha: 0.12),
          Colors.transparent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.2,
      4.1,
      false,
      subtleRing,
    );
  }

  @override
  bool shouldRepaint(covariant CyberOrbitPainter oldDelegate) => false;
}

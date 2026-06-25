import 'dart:math';
import 'package:flutter/material.dart';
import '../constants.dart';

class MeshBackground extends StatefulWidget {
  const MeshBackground({super.key});

  @override
  State<MeshBackground> createState() => _MeshBackgroundState();
}

class _MeshBackgroundState extends State<MeshBackground> {
  final List<Blob> _blobs = [];

  @override
  void initState() {
    super.initState();

    final List<Color> blobColors = [
      AppConstants.primaryColor.withValues(alpha: 0.12), // Pink
      AppConstants.activeIconColor.withValues(alpha: 0.12), // Cyan
      AppConstants.secondaryColor.withValues(alpha: 0.12), // Blue
      const Color(0xFF9B5FFE).withValues(alpha: 0.12), // Purple
      const Color(0xFF00FFD2).withValues(alpha: 0.12), // Cyber Cyan
    ];
    final random = Random();
    for (int i = 0; i < 5; i++) {
      _blobs.add(Blob(
        color: blobColors[i],
        position: Offset(random.nextDouble(), random.nextDouble()),
        radius: 0.5 + random.nextDouble() * 0.5,
        speed: Offset.zero, // No speed needed for static
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: MeshPainter(_blobs, 0.0),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class Blob {
  final Color color;
  Offset position;
  final double radius;
  final Offset speed;

  Blob(
      {required this.color,
      required this.position,
      required this.radius,
      required this.speed});

  void update() {
    position += speed;
    if (position.dx < -0.3 || position.dx > 1.3) {
      position = Offset(position.dx < -0.3 ? 1.3 : -0.3, position.dy);
    }
    if (position.dy < -0.3 || position.dy > 1.3) {
      position = Offset(position.dx, position.dy < -0.3 ? 1.3 : -0.3);
    }
  }
}

class MeshPainter extends CustomPainter {
  final List<Blob> blobs;
  final double t;

  MeshPainter(this.blobs, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) {
      return;
    }

    // Deep slate premium background base
    canvas.drawRect(Offset.zero & size, Paint()..color = AppConstants.bgColor);

    for (var blob in blobs) {
      final Offset center =
          Offset(blob.position.dx * size.width, blob.position.dy * size.height);

      final double radius = (size.width * blob.radius * 0.45).clamp(80.0, 450.0);

      // Senior Optimization: Use RadialGradient instead of MaskFilter.blur
      // MaskFilter.blur recalculates on the CPU/GPU every frame causing massive scroll jank.
      // RadialGradient is virtually free and produces the exact same aesthetic.
      final gradient = RadialGradient(
        colors: [
          blob.color,
          blob.color.withValues(alpha: 0.0),
        ],
      );

      final paint = Paint()
        ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius));

      // Large circles that wash over the background
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MeshPainter oldDelegate) => oldDelegate.t != t;
}

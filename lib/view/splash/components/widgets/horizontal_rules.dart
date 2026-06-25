import 'package:flutter/material.dart';
import '../painters/splash_painters.dart';

class HorizontalRules extends StatelessWidget {
  final double progress;
  const HorizontalRules({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      return CustomPaint(
        size: Size(w, 2),
        painter: HRulePainter(progress: progress, width: w),
      );
    });
  }
}

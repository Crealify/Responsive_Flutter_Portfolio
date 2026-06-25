import 'package:flutter/material.dart';

class Premium3DTilt extends StatefulWidget {
  final Widget child;
  final double maxTiltX; // Unused, kept for backward compatibility
  final double maxTiltY; // Unused, kept for backward compatibility
  final double depth; // Z-axis lift when hovered (e.g., 20.0)
  final double scale; // Scale factor when hovered (e.g., 1.05)

  const Premium3DTilt({
    super.key,
    required this.child,
    this.maxTiltX = 0.1,
    this.maxTiltY = 0.1,
    this.depth = 20.0,
    this.scale = 1.02,
  });

  @override
  State<Premium3DTilt> createState() => _Premium3DTiltState();
}

class _Premium3DTiltState extends State<Premium3DTilt> {
  final ValueNotifier<bool> _isHovered = ValueNotifier(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (context, isHovered, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250), // Standard smooth duration
            curve: Curves.easeOut, // Smooth momentum
            transform: Matrix4.identity()
              ..translateByDouble(0.0, isHovered ? -2.0 : 0.0, isHovered ? widget.depth : 0.0, 1.0) // Slight lift up
              ..scaleByDouble(
                 isHovered ? widget.scale : 1.0,
                 isHovered ? widget.scale : 1.0,
                 1.0,
                 1.0
              ),
            transformAlignment: Alignment.center,
            child: RepaintBoundary(child: widget.child),
          );
        },
      ),
    );
  }
}

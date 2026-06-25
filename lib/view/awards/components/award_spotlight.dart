import 'package:flutter/material.dart';

class AwardSpotlight extends StatelessWidget {
  final Offset mousePos;
  final Color accentColor;

  const AwardSpotlight({
    super.key,
    required this.mousePos,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      child: Transform.translate(
        offset: Offset(mousePos.dx - 125, mousePos.dy - 125),
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                accentColor.withValues(alpha: 0.15),
                Colors.transparent,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}

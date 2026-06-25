import 'package:flutter/material.dart';
class AnimatedSubtitleText extends StatelessWidget {
  final double start;
  final double end;
  final String text;
  final bool gradient;
  const AnimatedSubtitleText(
      {super.key, required this.start, required this.end, required this.text, this.gradient=false,});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        softWrap: false,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: 'Outfit',
            shadows: gradient
                ? [
                    Shadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 15),
                    Shadow(
                        color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                        offset: const Offset(0, 0),
                        blurRadius: 10),
                  ]
                : [],
            height: 1.1,
            fontSize: end),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Instantly loads the portfolio logo asset using native frameBuilder, 
/// falling back to a glowing '</>' code tag placeholder only while the image frame is genuinely unavailable.
class LogoWithPlaceholder extends StatelessWidget {
  final bool isHovered;
  final double height;
  const LogoWithPlaceholder({
    super.key,
    required this.isHovered,
    this.height = 38.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/portfolio_logo.png',
      height: height,
      fit: BoxFit.contain,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: frame != null
              ? KeyedSubtree(key: const ValueKey('logo'), child: child)
              : _buildPlaceholder(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder();
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      key: const ValueKey('placeholder'),
      height: height,
      width: height,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(height * 0.267),
        border: Border.all(
          color: Colors.cyanAccent.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.cyanAccent, Colors.purpleAccent],
        ).createShader(bounds),
        child: Text(
          '</>',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: height * 0.355,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class LetterAssembly extends StatelessWidget {
  final double progress;
  static const _letters = 'ANIL BHATTARAI';
  static const _highlightStart = 5;

  const LetterAssembly({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final revealStart = 0.25;
    final revealEnd = 0.75;
    final revealProgress = progress < revealStart
        ? 0.0
        : ((progress - revealStart) / (revealEnd - revealStart)).clamp(0.0, 1.0);

    final glowPulse = progress > 0.85
        ? 0.6 + 0.4 * math.sin(progress * 20)
        : 0.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_letters.length, (i) {
        final charDelay = i / _letters.length;
        final charProgress =
            Curves.easeOutBack.transform((revealProgress - charDelay * 0.6).clamp(0.0, 1.0));
        final isHighlight = i >= _highlightStart;
        final isSpace = _letters[i] == ' ';

        if (isSpace) return const SizedBox(width: 16);

        return Opacity(
          opacity: charProgress.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - charProgress.clamp(0.0, 1.0)) * 24),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: isHighlight
                    ? [const Color(0xFF06E5FF), AppConstants.activeIconColor]
                    : [Colors.white, const Color(0xFFE2E8F0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Text(
                _letters[i],
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  color: Colors.white,
                  fontFamily: 'Outfit',
                  shadows: [
                    if (isHighlight) ...[
                      Shadow(
                        color: AppConstants.activeIconColor.withValues(
                            alpha: 0.8 + glowPulse * 0.2),
                        blurRadius: 20 + glowPulse * 10,
                      ),
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 4,
                      ),
                    ] else ...[
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.15),
                        blurRadius: 8,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

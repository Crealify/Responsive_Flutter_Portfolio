import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants.dart';

// ─────────────────────────────────────────────────────────────────────────────
// The premium "reveal" strip shown when items are collapsed
// ─────────────────────────────────────────────────────────────────────────────
class RevealStrip extends StatelessWidget {
  final int hiddenCount;
  final AnimationController shimmerController;
  final VoidCallback onTap;
  final String itemName;

  const RevealStrip({
    super.key,
    required this.hiddenCount,
    required this.shimmerController,
    required this.onTap,
    required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: _ShimmerLine(shimmerController: shimmerController, reversed: false)),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppConstants.primaryColor.withValues(alpha: 0.35), width: 1),
                        gradient: LinearGradient(colors: [
                          AppConstants.primaryColor.withValues(alpha: 0.08),
                          AppConstants.activeIconColor.withValues(alpha: 0.05),
                        ]),
                        boxShadow: [
                          BoxShadow(color: AppConstants.primaryColor.withValues(alpha: 0.2), blurRadius: 24, spreadRadius: -4),
                        ],
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const PulsingDot(),
                            const SizedBox(width: 10),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [AppConstants.primaryColor, AppConstants.activeIconColor],
                              ).createShader(bounds),
                              child: Text(
                                '+$hiddenCount more $itemName${hiddenCount == 1 ? '' : 's'}',
                                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                              ),
                            ),
                            const SizedBox(width: 12),
                            AnimatedBuilder(
                              animation: shimmerController,
                              builder: (_, _) {
                                return Transform.translate(
                                  offset: Offset(0, 2 * (shimmerController.value < 0.5 ? shimmerController.value * 2 : (1 - shimmerController.value) * 2)),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: AppConstants.activeIconColor.withValues(alpha: 0.9), size: 18),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: _ShimmerLine(shimmerController: shimmerController, reversed: true)),
                  ],
                ),
                const SizedBox(height: 10),
                Text('tap to reveal',
                    style: TextStyle(color: AppConstants.subtitleColor.withValues(alpha: 0.5), fontSize: 11, letterSpacing: 1.4, fontWeight: FontWeight.w400))
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fadeIn(duration: 1200.ms)
                  .then()
                  .fadeOut(duration: 1200.ms),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  final AnimationController shimmerController;
  final bool reversed;

  const _ShimmerLine({required this.shimmerController, required this.reversed});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmerController,
      builder: (_, _) {
        final pos = shimmerController.value * 1.4;
        final colors = reversed
            ? [Colors.transparent, AppConstants.activeIconColor.withValues(alpha: 0.4), AppConstants.primaryColor.withValues(alpha: 0.6), Colors.transparent]
            : [Colors.transparent, AppConstants.primaryColor.withValues(alpha: 0.6), AppConstants.activeIconColor.withValues(alpha: 0.4), Colors.transparent];
        final stops = reversed
            ? [0.0, (1.0 - (pos + 0.15)).clamp(0.0, 1.0), (1.0 - pos).clamp(0.0, 1.0), 1.0]
            : [0.0, (pos * 1.4).clamp(0.0, 1.0), ((pos * 1.4) + 0.15).clamp(0.0, 1.0), 1.0];
        return Container(
          height: 1,
          decoration: BoxDecoration(gradient: LinearGradient(colors: colors, stops: stops)),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Minimal "collapse" affordance shown when all items are revealed
// ─────────────────────────────────────────────────────────────────────────────
class CollapseStrip extends StatelessWidget {
  final VoidCallback onTap;
  const CollapseStrip({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 40, height: 1, color: AppConstants.inactiveColor.withValues(alpha: 0.4)),
                const SizedBox(width: 14),
                Icon(Icons.keyboard_arrow_up_rounded, color: AppConstants.subtitleColor.withValues(alpha: 0.6), size: 16),
                const SizedBox(width: 8),
                Text('show less',
                    style: TextStyle(color: AppConstants.subtitleColor.withValues(alpha: 0.6), fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.w400)),
                const SizedBox(width: 14),
                Container(width: 40, height: 1, color: AppConstants.inactiveColor.withValues(alpha: 0.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Subtle pulsing dot indicating interactivity
// ─────────────────────────────────────────────────────────────────────────────
class PulsingDot extends StatelessWidget {
  const PulsingDot({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8,
      height: 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstants.activeIconColor.withValues(alpha: 0.3)),
          )
            .animate(onPlay: (c) => c.repeat())
            .scale(begin: const Offset(1, 1), end: const Offset(2.2, 2.2), duration: 1400.ms, curve: Curves.easeOut)
            .fadeOut(duration: 1400.ms),
          Container(width: 5, height: 5, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppConstants.activeIconColor)),
        ],
      ),
    );
  }
}

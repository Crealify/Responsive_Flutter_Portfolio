import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'painters/splash_painters.dart';
import 'widgets/horizontal_rules.dart';
import 'widgets/central_orbit.dart';
import 'widgets/letter_assembly.dart';
import 'widgets/role_text.dart';
import 'widgets/precision_progress.dart';
import 'widgets/side_calibration.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  PREMIUM CINEMATIC SPLASH SCREEN
//  Design: Precision geometry · Staged reveals · Arc progress · Name assembly
// ═══════════════════════════════════════════════════════════════════════════

class AnimatedLoadingText extends StatefulWidget {
  const AnimatedLoadingText({super.key});

  @override
  State<AnimatedLoadingText> createState() => _AnimatedLoadingTextState();
}

class _AnimatedLoadingTextState extends State<AnimatedLoadingText>
    with TickerProviderStateMixin {
  // Master timeline — drives every staged reveal
  late final AnimationController _masterCtrl;
  // Slow idle rotation for the decorative outer ring
  late final AnimationController _idleRotCtrl;
  // Ambient particle drift
  late final AnimationController _driftCtrl;

  @override
  void initState() {
    super.initState();
    _masterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400), // Sped up massively for fast reload
    )..forward();

    _idleRotCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _driftCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _masterCtrl.dispose();
    _idleRotCtrl.dispose();
    _driftCtrl.dispose();
    super.dispose();
  }

  double get _progress =>
      Curves.easeInOutCubic.transform(_masterCtrl.value.clamp(0.0, 1.0));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _masterCtrl,
      builder: (context, _) {
        final p = _progress;

        return Stack(
          children: [
            // ── Layer 0: Deep ambient gradient bg ─────────────────────────
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _idleRotCtrl,
                builder: (_, _) {
                  final pulse = 0.5 +
                      0.5 *
                          math.sin(_idleRotCtrl.value * 2 * math.pi);
                  return CustomPaint(
                    painter: AmbientBackgroundPainter(pulse: pulse, progress: p),
                  );
                },
              ),
            ),

            // ── Layer 1: Floating micro-particles ─────────────────────────
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _driftCtrl,
                builder: (_, _) => CustomPaint(
                  painter: FloatingParticlePainter(
                    t: _driftCtrl.value,
                    size: size,
                    progress: p,
                  ),
                ),
              ),
            ),

            // ── Layer 2: Thin horizontal rule lines ───────────────────────
            Positioned(
              top: size.height * 0.5 - 1,
              left: 0,
              right: 0,
              child: HorizontalRules(progress: p),
            ),

            // ── Layer 3+4: All centred content in one column ──────────────
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Orbital ring + logo
                    AnimatedBuilder(
                      animation: _idleRotCtrl,
                      builder: (_, _) => CentralOrbit(
                        progress: p,
                        idleAngle: _idleRotCtrl.value * 2 * math.pi,
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Name assembly
                    SizedBox(
                      width: math.min(size.width * 0.9, 800),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: LetterAssembly(progress: p),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Role line
                    SizedBox(
                      width: math.min(size.width * 0.9, 600),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RoleText(progress: p),
                      ),
                    ),

                    const SizedBox(height: 44),

                    // Progress bar + counter + moving icon
                    SizedBox(
                      width: math.min(size.width * 0.85, 440),
                      child: PrecisionProgress(progress: p),
                    ),
                  ],
                ),
              ),
            ),

            // ── Layer 5: Side calibration marks ───────────────────────────
            SideCalibration(size: size, progress: p),
          ],
        );
      },
    );
  }
}


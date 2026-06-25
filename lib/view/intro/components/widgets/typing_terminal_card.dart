import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mac_window_controls.dart';

class TypingTerminalCard extends StatelessWidget {
  final bool hasFocus;
  final Widget child;

  const TypingTerminalCard({
    super.key,
    required this.hasFocus,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: hasFocus ? 0.16 : 0.06),
            blurRadius: hasFocus ? 35 : 20,
            spreadRadius: -2,
            offset: const Offset(-4, -4),
          ),
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: hasFocus ? 0.20 : 0.08),
            blurRadius: hasFocus ? 40 : 25,
            spreadRadius: -2,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasFocus
                    ? const Color(0xFF06B6D4).withValues(alpha: 0.35)
                    : const Color(0xFF3B82F6).withValues(alpha: 0.18),
                width: 1.0,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF07111F).withValues(alpha: 0.8),
                  const Color(0xFF0B1020).withValues(alpha: 0.65),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.04),
                            Colors.transparent,
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.35, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TypingTitleBar extends StatelessWidget {
  final String title;
  const TypingTitleBar({super.key, this.title = "anil_bhattarai.dart"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: CrazyMacWindowControls(),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.firaCode(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: HeaderDotGrid(),
            ),
          ),
        ],
      ),
    );
  }
}

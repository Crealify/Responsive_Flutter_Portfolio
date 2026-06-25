import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'painters/cyber_orbit_painter.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -45,
          right: -45,
          child: IgnorePointer(
            child: SizedBox(
              width: 320,
              height: 320,
              child: RepaintBoundary(
                child: CustomPaint(painter: const CyberOrbitPainter()),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 280,
          height: 390,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withValues(alpha: 0.5), // Softer deep blue
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: const Color(0xFF06B6D4).withValues(alpha: 0.15), // Softer border
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF06B6D4).withValues(alpha: 0.05), // Ultra subtle ambient glow
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image with Elegant Gradient Border
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
                    colors: [
                      Color(0xFF06B6D4),
                      Color(0xFF3B82F6),
                      Color(0xFF8B5CF6),
                      Color(0xFF06B6D4),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0F172A),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFF06B6D4),
                        ),
                      ),
                    ),
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(end: 1.03, duration: 2500.ms),
              const SizedBox(height: 14),
              
              // Name
              const Text(
                'Anil Bhattarai',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              // Role
              Text(
                'Computer Engineer\nFlutter Developer',
                style: TextStyle(
                  color: const Color(0xFF94A3B8), // Elegant slate grey
                  fontSize: 12,
                  height: 1.4,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 14),
              
              // Cyber divider
              Container(
                height: 1,
                width: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xFF06B6D4).withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 14),
              
              // Horizontal Stats Layout (Elegant)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFuturisticStat('2+', 'Years\nExp'),
                  _buildFuturisticStat('20+', 'Projects\nDone'),
                  _buildFuturisticStat('100%', 'Client\nSat.'),
                ],
              ),
              
              const Spacer(),
              
              // Tech Stack Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIcon('assets/icons/flutter.png', isPng: true),
                  _buildIcon('assets/icons/firebase.png', isPng: true),
                  _buildIcon('assets/icons/dart.png', isPng: true),
                  _buildIcon('assets/icons/github.svg'),
                ],
              ),
            ],
          ),
        ),
        ),
        ),
      ],
    );
  }

  Widget _buildFuturisticStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF06B6D4), // Clean cyan
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF94A3B8), // Elegant slate
            fontSize: 10,
            height: 1.3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(String assetPath, {bool isPng = false}) {
    return Container(
      width: 36,
      height: 36,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: isPng
          ? Image.asset(
              assetPath,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.code, size: 16, color: Colors.white54),
            )
          : SvgPicture.asset(
              assetPath,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
    );
  }
}

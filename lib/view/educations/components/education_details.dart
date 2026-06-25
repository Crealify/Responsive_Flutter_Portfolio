import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'education_card_content.dart';

/// A state-of-the-art interactive Academic Card with 3D perspective tilt,
/// neon cyber-border accents, and layered glassmorphism.
class EducationCard extends StatefulWidget {
  final int index;
  final ValueChanged<bool>? onHover;
  const EducationCard({super.key, required this.index, this.onHover});

  @override
  State<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  bool _isHovered = false;

  void _setHovered(bool hover) {
    setState(() => _isHovered = hover);
    widget.onHover?.call(hover);
  }

  @override
  Widget build(BuildContext context) {
    final edu = Get.find<PortfolioController>().educations[widget.index];

    // Alternating cyber highlights matching the parent timeline branches
    final Color cyberColor =
        widget.index == 0 ? const Color(0xFF00FFD2) : const Color(0xFFFF00A0);

    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Enable 3D perspective
          ..rotateY(_isHovered ? (widget.index % 2 == 0 ? 0.04 : -0.04) : 0.0)
          ..rotateX(_isHovered ? 0.02 : 0.0),
        transformAlignment: Alignment.center,
        child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(edu.link),
                mode: LaunchMode.externalApplication);
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withValues(alpha: 0.7), // Fast opaque glass alternative
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? cyberColor.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.06),
                width: 1.2,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: cyberColor.withValues(alpha: 0.15),
                    blurRadius: 35,
                    spreadRadius: -2,
                    offset: const Offset(0, 10),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Removed expensive BackdropFilter for silky smooth 60fps scrolling

                  // Layer 2: Moving particle/glow backing on hover
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: 400.ms,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: _isHovered ? 1.5 : 1.0,
                          colors: [
                            _isHovered
                                ? cyberColor.withValues(alpha: 0.08)
                                : Colors.white.withValues(alpha: 0.02),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Layer 3: Main visual content card
                  EducationCardContent(
                    edu: edu,
                    isHovered: _isHovered,
                    cyberColor: cyberColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

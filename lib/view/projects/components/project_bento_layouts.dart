import 'package:flutter/material.dart';
import 'project_details.dart';
import 'project_showcase_mockup.dart';

class WideBentoLayout extends StatelessWidget {
  final dynamic proj;
  final bool isHovered;
  final Color accent;
  final bool isCompactWide;

  const WideBentoLayout({
    super.key,
    required this.proj,
    required this.isHovered,
    required this.accent,
    required this.isCompactWide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectShowcaseMockup(proj: proj, isHovered: isHovered, accent: accent, isCompactWide: isCompactWide),
        SizedBox(height: isCompactWide ? 16 : 24),
        ProjectTitle(proj: proj, isHovered: isHovered, accent: accent, isCompactWide: isCompactWide),
        SizedBox(height: isCompactWide ? 8 : 12),
        ProjectDescription(proj: proj, isCompactWide: isCompactWide),
        SizedBox(height: isCompactWide ? 16 : 24),
        ProjectTechBadges(proj: proj, isHovered: isHovered, accent: accent, isCompactWide: isCompactWide),
        SizedBox(height: isCompactWide ? 16 : 24),
        ProjectActionBtn(proj: proj, accent: accent),
      ],
    );
  }
}

class StandardBentoLayout extends StatelessWidget {
  final dynamic proj;
  final bool isHovered;
  final Color accent;

  const StandardBentoLayout({
    super.key,
    required this.proj,
    required this.isHovered,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectTitle(proj: proj, isHovered: isHovered, accent: accent, isCompactWide: false),
        const SizedBox(height: 12),
        ProjectDescription(proj: proj, isCompactWide: false),
        const SizedBox(height: 20),
        ProjectShowcaseMockup(proj: proj, isHovered: isHovered, accent: accent, isCompactWide: false),
        const SizedBox(height: 24),
        ProjectTechBadges(proj: proj, isHovered: isHovered, accent: accent, isCompactWide: false),
        const SizedBox(height: 24),
        ProjectActionBtn(proj: proj, accent: accent),
      ],
    );
  }
}

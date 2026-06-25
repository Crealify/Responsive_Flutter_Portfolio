import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../../res/constants.dart';
import '../../../../res/components/premium_button.dart';

class ProjectTitle extends StatelessWidget {
  final dynamic proj;
  final bool isHovered;
  final Color accent;
  final bool isCompactWide;

  const ProjectTitle({
    super.key,
    required this.proj,
    required this.isHovered,
    required this.accent,
    required this.isCompactWide,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: 300.ms,
      style: TextStyle(
        color: isHovered ? accent : Colors.white,
        fontSize: isCompactWide ? 17 : 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'Outfit',
        letterSpacing: 0.6,
        shadows: [
          if (isHovered) Shadow(color: accent.withValues(alpha: 0.5), blurRadius: 12),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(proj.name),
      ),
    );
  }
}

class ProjectDescription extends StatelessWidget {
  final dynamic proj;
  final bool isCompactWide;

  const ProjectDescription({
    super.key,
    required this.proj,
    required this.isCompactWide,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      proj.description,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: AppConstants.bodyTextColor,
        fontSize: isCompactWide ? 12.0 : 13.0,
        height: 1.6,
      ),
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ProjectTechBadges extends StatelessWidget {
  final dynamic proj;
  final bool isHovered;
  final Color accent;
  final bool isCompactWide;

  const ProjectTechBadges({
    super.key,
    required this.proj,
    required this.isHovered,
    required this.accent,
    required this.isCompactWide,
  });

  @override
  Widget build(BuildContext context) {
    if (proj.technologies.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: isCompactWide ? 6 : 8,
      runSpacing: isCompactWide ? 6 : 8,
      children: proj.technologies.map<Widget>((tech) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompactWide ? 8 : 10,
            vertical: isCompactWide ? 4 : 5,
          ),
          decoration: BoxDecoration(
            color: isHovered ? accent.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHovered ? accent.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Text(
            tech,
            style: TextStyle(
              color: isHovered ? accent : Colors.white60,
              fontSize: isCompactWide ? 9.5 : 10.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontFamily: 'Outfit',
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ProjectActionBtn extends StatelessWidget {
  final dynamic proj;
  final Color accent;

  const ProjectActionBtn({
    super.key,
    required this.proj,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumButton(
      text: proj.link.contains('github.com') ? 'Explore Repository' : 'Launch Live App',
      icon: Icons.arrow_forward_rounded,
      isUpperCase: false,
      gradient: [accent.withValues(alpha: 0.8), accent.withValues(alpha: 0.4)],
      onTap: () {
        Get.find<PortfolioController>().trackAction('project_link_click_${proj.name}');
        launchUrl(Uri.parse(proj.link), mode: LaunchMode.externalApplication);
      },
    );
  }
}

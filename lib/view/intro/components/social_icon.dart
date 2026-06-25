import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/constants.dart';
class SocialMediaIcon extends StatefulWidget {
  const SocialMediaIcon({super.key, required this.icon, this.onTap});
  final String icon;
  final VoidCallback? onTap;

  @override
  State<SocialMediaIcon> createState() => _SocialMediaIconState();
}

class _SocialMediaIconState extends State<SocialMediaIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppConstants.primaryColor; // Violet (#8B5CF6)
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(vertical: 6),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isHovered 
              ? activeColor.withValues(alpha: 0.15) 
              : Colors.white.withValues(alpha: 0.03),
          border: Border.all(
            color: _isHovered 
                ? activeColor.withValues(alpha: 0.5) 
                : Colors.white.withValues(alpha: 0.08),
            width: 1.0,
          ),
          boxShadow: _isHovered 
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  )
                ] 
              : [],
        ),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0), // macOS dock lift effect!
        child: InkWell(
          onTap: widget.onTap,
          customBorder: const CircleBorder(),
          child: Center(
            child: _buildIconContent(_isHovered ? activeColor : Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildIconContent(Color color) {
    if (widget.icon.startsWith('http')) {
      return SvgPicture.network(
        widget.icon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        height: 18,
        width: 18,
        placeholderBuilder: (context) => const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 1),
        ),
      );
    }

    // High-performance instant glyph fallbacks for defaults
    if (widget.icon.contains('linkedin')) return FaIcon(FontAwesomeIcons.linkedinIn, color: color, size: 18);
    if (widget.icon.contains('github')) return FaIcon(FontAwesomeIcons.github, color: color, size: 18);
    if (widget.icon.contains('facebook')) return FaIcon(FontAwesomeIcons.facebookF, color: color, size: 18);
    if (widget.icon.contains('youtube')) return FaIcon(FontAwesomeIcons.youtube, color: color, size: 18);
    if (widget.icon.contains('instagram')) return FaIcon(FontAwesomeIcons.instagram, color: color, size: 18);
    
    return SvgPicture.asset(
      widget.icon,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      height: 18,
      width: 18,
    );
  }
}

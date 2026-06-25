import 'package:flutter/material.dart';

/// Interactive navigation text button with hover and active state animations.
class NavigationTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final bool isActive;

  const NavigationTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isActive = false,
  });

  @override
  State<NavigationTextButton> createState() => _NavigationTextButtonState();
}

class _NavigationTextButtonState extends State<NavigationTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.isActive;
    final Color activeColor = const Color(0xFF06B6D4); // Cyber Cyan

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isActive
                      ? activeColor
                      : (_isHovered ? Colors.white : Colors.white60),
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontFamily: 'Inter',
                  letterSpacing: 0.8,
                ),
                child: Text(widget.text),
              ),
              const SizedBox(height: 4),
              // Glowing Active Indicator Dot
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isActive ? 1.0 : 0.0,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: activeColor.withValues(alpha: 0.8),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

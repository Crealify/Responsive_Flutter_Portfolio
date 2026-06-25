import 'package:flutter/material.dart';

class SecondaryResumeButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;

  const SecondaryResumeButton({
    super.key,
    required this.text,
    required this.onTap,
    this.padding,
  });

  @override
  State<SecondaryResumeButton> createState() => _SecondaryResumeButtonState();
}

class _SecondaryResumeButtonState extends State<SecondaryResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isHovered ? Colors.white : Colors.white70,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  decoration: _isHovered ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                  letterSpacing: 0.8,
                ),
                child: Text(widget.text),
              ),
              const SizedBox(width: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(_isHovered ? 4 : 0, 0, 0),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: _isHovered ? Colors.white : Colors.white70,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

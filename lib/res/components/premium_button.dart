import 'package:flutter/material.dart';
import '../constants.dart';

class PremiumButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final Widget? prefixIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final List<Color>? gradient;
  final bool isSecondary;
  final double? width;
  final bool isUpperCase;

  const PremiumButton({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.prefixIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.gradient,
    this.isSecondary = false,
    this.width,
    this.isUpperCase = true,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.isLoading || widget.onTap == null;

    final primaryGradient = widget.gradient ??
        const [
          AppConstants.primaryColor,
          AppConstants.secondaryColor,
        ];

    final secondaryGradient = [
      Colors.white.withValues(alpha: _isHovered ? 0.08 : 0.02),
      Colors.white.withValues(alpha: _isHovered ? 0.03 : 0.005),
    ];

    return MouseRegion(
      onEnter: (_) => {if (!isDisabled) setState(() => _isHovered = true)},
      onExit: (_) => {if (!isDisabled) setState(() => _isHovered = false)},
      cursor:
          isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered && !isDisabled ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: InkWell(
          onTap: isDisabled ? null : widget.onTap,
          borderRadius: BorderRadius.circular(30),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: isDisabled
                    ? [
                        Colors.grey.withValues(alpha: 0.4),
                        Colors.grey.withValues(alpha: 0.4)
                      ]
                    : (widget.isSecondary
                        ? secondaryGradient
                        : primaryGradient),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              color: widget.isSecondary && !isDisabled
                  ? Colors.white.withValues(alpha: _isHovered ? 0.08 : 0.05)
                  : null,
              border: Border.all(
                color: widget.isSecondary
                    ? Colors.white.withValues(alpha: _isHovered ? 0.5 : 0.2)
                    : Colors.white.withValues(alpha: _isHovered ? 0.5 : 0.2),
                width: widget.isSecondary ? 1.5 : 1.0,
              ),
              boxShadow: [
                if (!isDisabled && !widget.isSecondary)
                  BoxShadow(
                    color: primaryGradient.first
                        .withValues(alpha: _isHovered ? 0.45 : 0.25),
                    offset: const Offset(0, 4),
                    blurRadius: _isHovered ? 20 : 12,
                  )
                else if (!isDisabled && widget.isSecondary && _isHovered)
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
              ],
            ),
            child: widget.isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: widget.width != null
                        ? MainAxisSize.max
                        : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, color: Colors.white, size: 14),
                        const SizedBox(width: 8),
                      ] else if (widget.prefixIcon != null) ...[
                        widget.prefixIcon!,
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          widget.isUpperCase ? widget.text.toUpperCase() : widget.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 12.5,
                            fontFamily: 'Outfit',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.trailingIcon != null) ...[
                        const SizedBox(width: 8),
                        widget.trailingIcon!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

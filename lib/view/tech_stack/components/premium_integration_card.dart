import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:anilbhattarai_portfolio/res/constants.dart';
import 'package:anilbhattarai_portfolio/view_model/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tech_data.dart';

class PremiumIntegrationCard extends StatefulWidget {
  final TechSkill skill;
  final int index;
  final bool isDesktop;

  const PremiumIntegrationCard({super.key, required this.skill, required this.index, required this.isDesktop});

  @override
  State<PremiumIntegrationCard> createState() => _PremiumIntegrationCardState();
}

class _PremiumIntegrationCardState extends State<PremiumIntegrationCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final String name = widget.skill.name.toLowerCase();

    Color glowColor = const Color(0xFF3B82F6);
    String description = '';
    IconData icon = Icons.account_balance_wallet_outlined;

    if (name.contains('stripe')) {
      glowColor = const Color(0xFF635BFF);
      description = 'Complete implementation of Stripe Payment Gateway including Payment Intents, Webhooks, and secure client-side handling.';
      icon = Icons.credit_card_outlined;
    } else if (name.contains('esewa')) {
      glowColor = const Color(0xFF61B15A);
      description = 'Deep integration of eSewa native SDK for seamless domestic payment processing in Nepal, ensuring reliable transactions.';
      icon = Icons.account_balance_rounded;
    } else if (name.contains('khalti')) {
      glowColor = const Color(0xFFA855F7);
      description = 'Robust integration of Khalti Payment Gateway SDK for secure digital wallet and banking transactions across Nepal.';
      icon = Icons.payments_outlined;
    }

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          transform: Matrix4.translationValues(0.0, isHovered ? -12.0 : 0.0, 0.0)
            ..multiply(Matrix4.diagonal3Values(isHovered ? 1.02 : 1.0, isHovered ? 1.02 : 1.0, 1.0)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: isHovered ? 0.05 : 0.025),
                Colors.white.withValues(alpha: isHovered ? 0.015 : 0.005),
              ],
            ),
            border: Border.all(
              color: isHovered ? glowColor.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.06),
              width: 1.2,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(color: glowColor.withValues(alpha: 0.12), blurRadius: 25, spreadRadius: -4, offset: const Offset(0, 8)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topLeft,
                        radius: isHovered ? 1.4 : 0.6,
                        colors: [glowColor.withValues(alpha: isHovered ? 0.12 : 0.0), Colors.transparent],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 18 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: EdgeInsets.all(isMobile ? 10 : 14),
                            decoration: BoxDecoration(
                              color: glowColor.withValues(alpha: isHovered ? 0.2 : 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(color: glowColor.withValues(alpha: isHovered ? 0.4 : 0.2)),
                              boxShadow: [BoxShadow(color: glowColor.withValues(alpha: isHovered ? 0.4 : 0.2), blurRadius: isHovered ? 15 : 10, spreadRadius: 1)],
                            ),
                            child: Icon(icon, color: glowColor, size: isMobile ? 22 : 28),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: glowColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: glowColor.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified, color: glowColor, size: isMobile ? 12 : 14),
                                const SizedBox(width: 4),
                                Text('Expert Level',
                                    style: GoogleFonts.inter(color: glowColor, fontSize: isMobile ? 10 : 12, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                              ],
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 3.seconds, color: Colors.white24),
                        ],
                      ),
                      SizedBox(height: isMobile ? 20 : 28),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.skill.name,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            shadows: [if (isHovered) Shadow(color: glowColor.withValues(alpha: 0.6), blurRadius: 12)],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) => FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: constraints.maxWidth,
                            child: Text(description,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.inter(
                                    color: AppConstants.subtitleColor,
                                    fontSize: isMobile ? 12.5 : 13.5,
                                    height: isMobile ? 1.5 : 1.65,
                                    letterSpacing: 0.1)),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 28),
                      Wrap(
                        spacing: isMobile ? 6 : 10,
                        runSpacing: isMobile ? 6 : 10,
                        children: [_buildTag('Security First', glowColor, isMobile), _buildTag('Production', glowColor, isMobile)],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    .animate()
    .fade(duration: 800.ms, delay: (200 * widget.index).ms)
    .slideY(begin: 0.1);
  }

  Widget _buildTag(String text, Color color, bool isMobile) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 12, vertical: isMobile ? 4 : 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isHovered ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: isHovered ? 0.4 : 0.2)),
      ),
      child: Text(text,
          style: GoogleFonts.inter(color: color.withValues(alpha: 0.9), fontSize: isMobile ? 10 : 12, fontWeight: FontWeight.w500)),
    );
  }
}

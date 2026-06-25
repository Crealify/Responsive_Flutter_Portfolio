import 'package:flutter/material.dart';
import '../../../../view_model/responsive.dart';

import 'combine_subtitle.dart';
import 'description_text.dart';
import 'download_button.dart';
import 'headline_text.dart';

class HeroTextSection extends StatelessWidget {
  const HeroTextSection({super.key});

  Widget _buildAvailableForWorkBadge() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 4, right: 14, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF06B6D4).withValues(alpha: 0.05), // Faint cyan glass
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: const Color(0xFF06B6D4).withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF06B6D4).withValues(alpha: 0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cyber left-accent line
            Container(
              width: 3,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF06B6D4),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF06B6D4).withValues(alpha: 0.5),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const RepaintBoundary(child: GreenPulseDot()),
            const SizedBox(width: 8),
            const Text(
              'STATUS: AVAILABLE FOR WORK',
              style: TextStyle(
                color: Color(0xFF06B6D4),
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: 'Outfit',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvailableForWorkBadge(),
        const SizedBox(height: 20),
        const Responsive(
          extraLargeScreen: MyPortfolioText(start: 60, end: 84),
          desktop: MyPortfolioText(start: 50, end: 72),
          largeMobile: MyPortfolioText(start: 40, end: 50),
          mobile: MyPortfolioText(start: 35, end: 42),
          tablet: MyPortfolioText(start: 45, end: 60),
        ),
        const SizedBox(height: 16),
        const CombineSubtitleText(),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: const Responsive(
            extraLargeScreen: AnimatedDescriptionText(start: 20, end: 22),
            desktop: AnimatedDescriptionText(start: 18, end: 20),
            largeMobile: AnimatedDescriptionText(start: 16, end: 18),
            mobile: AnimatedDescriptionText(start: 15, end: 17),
            tablet: AnimatedDescriptionText(start: 17, end: 19),
          ),
        ),
        const SizedBox(height: 32),
        const DownloadButton(),
      ],
    );
  }
}

class GreenPulseDot extends StatefulWidget {
  const GreenPulseDot({super.key});

  @override
  State<GreenPulseDot> createState() => _GreenPulseDotState();
}

class _GreenPulseDotState extends State<GreenPulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ScaleTransition(
          scale: Tween(begin: 1.0, end: 2.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut),
          ),
          child: FadeTransition(
            opacity: Tween(begin: 0.6, end: 0.0).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOut),
            ),
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF10B981), // Emerald pulse
              ),
            ),
          ),
        ),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF10B981),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF10B981),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

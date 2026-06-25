import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:anilbhattarai_portfolio/res/constants.dart';
import '../../../view_model/responsive.dart';
import '../../../res/components/premium_3d_tilt.dart'; // Import the new 3D tilt
import 'animated_texts_components.dart';
import 'info_card.dart';
import 'hero_text_section.dart';

class IntroBody extends StatelessWidget {
  const IntroBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: AppConstants.spacing12,
        bottom: spacing40,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Premium3DTilt(
                    maxTiltX: 0.05,
                    maxTiltY: 0.05,
                    depth: 10.0,
                    scale: 1.02,
                    child: const HeroTextSection(),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideY(begin: 0.1),
                const SizedBox(
                    width: AppConstants.spacing24), // Small elegant gap
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 58.0), // 70 total to align with Social handles
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: InfoCard(),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .scale(begin: const Offset(0.9, 0.9)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AnimatedImageContainer(width: 130, height: 160)
                    .animate()
                    .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic)
                    .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutCubic),
                const SizedBox(height: 24),
                Premium3DTilt(
                  maxTiltX: 0.05,
                  maxTiltY: 0.05,
                  depth: 10.0,
                  scale: 1.02,
                  child: const HeroTextSection(),
                )
                    .animate()
                    .fadeIn(
                        delay: 200.ms,
                        duration: 600.ms,
                        curve: Curves.easeOutCubic)
                    .slideY(begin: 0.1, curve: Curves.easeOutCubic),
              ],
            ),
    );
  }
}

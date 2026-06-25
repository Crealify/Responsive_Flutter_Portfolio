import 'package:anilbhattarai_portfolio/view/intro/components/animated_texts_components.dart';
import 'package:anilbhattarai_portfolio/view/intro/components/intro_body.dart';
import 'package:anilbhattarai_portfolio/view/intro/components/social_media_list.dart';
import 'package:anilbhattarai_portfolio/view/intro/components/hero_text_section.dart';
import 'package:anilbhattarai_portfolio/view_model/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../res/constants.dart';
import '../../view_model/responsive.dart';

/// Hero section of the portfolio, featuring social links and key intro text.
class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Social Media List (Entrance from Left) - Hidden when menu is open to match design
        Obx(() => !appController.isMenuOpen.value
            ? Padding(
                padding: const EdgeInsets.only(top: AppConstants.spacing70),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SocialMediaIconList()
                        .animate()
                        .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
                        .slideX(begin: -0.2, curve: Curves.easeOutCubic),
                    const SizedBox(width: AppConstants.spacing48),
                  ],
                ),
              )
            : const SizedBox.shrink()),

        const Expanded(
          child: IntroBody(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const Center(
          child: AnimatedImageContainer(
            width: 130,
            height: 160,
          ),
        ),
        const SizedBox(
            height: AppConstants.spacing16), // Reduced from 32 for "small gap"
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SocialMediaIconList(),
            SizedBox(width: AppConstants.spacing16),
            Expanded(
              child: HeroTextSection(),
            ),
          ],
        ),
      ],
    );
  }
}

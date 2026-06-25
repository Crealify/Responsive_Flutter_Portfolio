import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';
import '../../../view_model/controller.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../res/components/premium_button.dart';
import 'business_contact_modal.dart';

/// The final call-to-action and footer section of the portfolio.
class PortfolioEnding extends StatelessWidget {
  const PortfolioEnding({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final PortfolioController pc = Get.find();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 80,
        bottom: 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.015),
            Colors.black.withValues(alpha: 0.95),
          ],
        ),
        border: const Border(
          top: BorderSide(color: Colors.white12, width: 1.2),
        ),
      ),
      child: Obx(() {
        final config = pc.ctaConfig.value;

        // Calculate standard horizontal padding to perfectly match the grid above
        final double horizontalPadding =
            screenWidth < 600 ? 16 : (screenWidth < 1200 ? 32 : 48);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  // --- Headline ---
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.white, Colors.white70],
                    ).createShader(bounds),
                    child: Text(
                      config.headline.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize:
                            isDesktop ? 34 : (screenWidth < 400 ? 19 : 23),
                        fontFamily: 'Outfit',
                        letterSpacing: 1.5,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing16),

                  // --- Subtext ---
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        config.subtext,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isDesktop ? 14.0 : 11.5,
                          height: 1.6,
                          fontFamily: 'Inter_regular',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing40),

                  // --- CTAs ---
                  Wrap(
                    spacing: AppConstants.spacing24,
                    runSpacing: AppConstants.spacing16,
                    alignment: WrapAlignment.center,
                    children: [
                      // Primary CTA
                      PremiumButton(
                        width: Responsive.isMobile(context)
                            ? double.infinity
                            : 220,
                        text: config.primaryButtonText
                            .replaceAll(RegExp(r'[🚀📁]'), '')
                            .trim(),
                        icon: Icons.rocket_launch_rounded,
                        gradient: const [
                          Color(0xFF10B981), // Premium Emerald Green (Action, Trust, Growth)
                          Color(0xFF06B6D4), // Brand Cyan (Professional, Tech)
                        ],
                        onTap: () {
                          pc.trackAction('start_a_project_click');
                          showBusinessContactDialog(context);
                        },
                      ),
                      // Secondary CTA
                      PremiumButton(
                        width: Responsive.isMobile(context)
                            ? double.infinity
                            : 220,
                        text: config.secondaryButtonText
                            .replaceAll(RegExp(r'[🚀📁]'), '')
                            .trim(),
                        icon: Icons.folder_open_rounded,
                        isSecondary: true,
                        onTap: () {
                          Get.find<PortfolioController>()
                              .trackAction('footer_view_projects');
                          appController
                              .scrollToSection(AppController.projectsKey);
                          appController.updateIndex(1);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  // --- Footer ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 1.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing32),
                  Text(
                    config.footerText.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

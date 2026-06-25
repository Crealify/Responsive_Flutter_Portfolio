import 'dart:ui';
import 'package:anilbhattarai_portfolio/view/intro/components/social_media_coloumn.dart';
import 'package:anilbhattarai_portfolio/view/intro/components/side_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/responsive.dart';
import '../../../view_model/controller.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';

class SocialMediaIconList extends StatelessWidget {
  const SocialMediaIconList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isMenuOpen = appController.isMenuOpen.value;
      final bool isDesktop = Responsive.isDesktop(context);

      // Hide the follow column on desktop if the drawer is open (as requested)
      if (isDesktop && isMenuOpen) {
        return const SizedBox.shrink();
      }

      return RepaintBoundary(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: const Color(0xFF07111F).withValues(alpha: 0.6),
          border: Border.all(
            color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF06B6D4).withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Column(
              mainAxisAlignment:
                  isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 42,
                  height: 42,
                  child: MenuButton(
                    onTap: () {
                      if (isDesktop) {
                        Get.find<PortfolioController>().trackAction('drawer_toggle');
                        appController.toggleMenu();
                      } else {
                        Get.find<PortfolioController>()
                            .trackAction('drawer_open_mobile');
                        Scaffold.of(context).openDrawer();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Thin glowing cyber divider line
                Container(
                  height: 1.0,
                  width: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF06B6D4).withValues(alpha: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF06B6D4).withValues(alpha: 0.8),
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SocialMediaIconColumn(),
              ],
            ),
          ),
        ),
        ),
      );
    });
  }
}

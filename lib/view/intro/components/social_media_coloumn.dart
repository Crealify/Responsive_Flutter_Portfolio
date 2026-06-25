import 'package:anilbhattarai_portfolio/view/intro/components/social_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class SocialMediaIconColumn extends StatelessWidget {
  const SocialMediaIconColumn({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sc = Get.find<PortfolioController>().socialConfig.value;
      return RepaintBoundary(
        child: Column(
          children: [
            if (sc.linkedin.isNotEmpty)
              SocialMediaIcon(
                  icon: sc.linkedinIcon, // Controllable from backend
                  onTap: () {
                    Get.find<PortfolioController>()
                        .trackAction('hero_social_click_linkedin');
                    launchUrl(Uri.parse(sc.linkedin),
                        mode: LaunchMode.externalApplication);
                  }),
            if (sc.github.isNotEmpty)
              SocialMediaIcon(
                icon: sc.githubIcon, // Controllable from backend
                onTap: () {
                  Get.find<PortfolioController>()
                      .trackAction('hero_social_click_github');
                  launchUrl(Uri.parse(sc.github),
                      mode: LaunchMode.externalApplication);
                },
              ),
            if (sc.facebook.isNotEmpty)
              SocialMediaIcon(
                  icon: sc.facebookIcon, // Controllable from backend
                  onTap: () {
                    Get.find<PortfolioController>()
                        .trackAction('hero_social_click_facebook');
                    launchUrl(Uri.parse(sc.facebook),
                        mode: LaunchMode.externalApplication);
                  }),
            if (sc.youtube.isNotEmpty)
              SocialMediaIcon(
                  icon: sc.youtubeIcon, // Controllable from backend
                  onTap: () {
                    Get.find<PortfolioController>()
                        .trackAction('hero_social_click_youtube');
                    launchUrl(Uri.parse(sc.youtube),
                        mode: LaunchMode.externalApplication);
                  }),
            if (sc.instagram.isNotEmpty)
              SocialMediaIcon(
                icon: sc.instagramIcon, // Controllable from backend
                onTap: () {
                  Get.find<PortfolioController>()
                      .trackAction('hero_social_click_instagram');
                  launchUrl(Uri.parse(sc.instagram),
                      mode: LaunchMode.externalApplication);
                },
              ),
          ],
        ),
      );
    });
  }
}

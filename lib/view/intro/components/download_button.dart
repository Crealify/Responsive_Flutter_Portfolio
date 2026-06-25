import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';
import '../../../view_model/controller.dart';
import '../../../res/components/premium_button.dart';
import 'secondary_resume_button.dart';

/// Opens a URL in a new browser tab (works on Flutter Web).
Future<void> _openUrl(BuildContext context, String url) async {
  if (url.isEmpty) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resume URL is not configured yet.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    return;
  }

  String targetUrl = url;

  final Uri uri = Uri.parse(targetUrl);
  // LaunchMode.platformDefault + webOnlyWindowName '_blank' is the correct
  // way to open a URL in a new tab on Flutter Web.
  // LaunchMode.externalApplication is silently ignored on web.
  final bool launched = await launchUrl(
    uri,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: '_blank',
  );

  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open resume. URL: $targetUrl'),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Primary call-to-action buttons for the introduction section.
class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Obx(() {
      final hc = Get.find<PortfolioController>().heroConfig.value;
      if (!isDesktop) {
        final double screenWidth = MediaQuery.sizeOf(context).width;
        final double buttonWidth = Responsive.isTablet(context)
            ? 490
            : (screenWidth * 0.8) - 10;

        return Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PremiumButton(
                text: 'Explore My Work',
                icon: Icons.rocket_launch_outlined,
                isUpperCase: false,
                width: buttonWidth,
                onTap: () {
                  Get.find<PortfolioController>()
                      .trackAction('mobile_hero_cta_click');
                  appController.scrollToSection(AppController.projectsKey);
                  appController.updateIndex(1);
                },
              ),
              const SizedBox(height: AppConstants.spacing12),
              SizedBox(
                width: buttonWidth,
                child: Center(
                  child: SecondaryResumeButton(
                    text: 'View Resume',
                    onTap: () {
                      Get.find<PortfolioController>()
                          .trackAction('mobile_resume_view');
                      _openUrl(context, hc.resumeUrl);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return Wrap(
        spacing: AppConstants.spacing24,
        runSpacing: AppConstants.spacing16,
        alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Primary CTA
          PremiumButton(
            text: 'Explore My Work',
            icon: Icons.rocket_launch_outlined,
            isUpperCase: false,
            onTap: () {
              Get.find<PortfolioController>().trackAction('hero_cta_click');
              appController.scrollToSection(AppController.projectsKey);
              appController.updateIndex(1);
            },
          ),

          // View Resume
          SecondaryResumeButton(
            text: 'View Resume',
            onTap: () {
              Get.find<PortfolioController>().trackAction('resume_view');
              _openUrl(context, hc.resumeUrl);
            },
          ),
        ],
      );
    });
  }
}

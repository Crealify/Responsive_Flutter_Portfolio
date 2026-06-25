import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/web_utils.dart' as web_utils;

import '../../../../res/constants.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'header_info.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Obx(() {
      final contact = controller.contactConfig.value;
      final social = controller.socialConfig.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Info',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          AreaInfoText(
            title: 'Email', 
            icon: Icons.email_rounded,
            text: contact.email.isNotEmpty ? contact.email : 'Not Available',
            onTap: contact.email.isNotEmpty ? () {
              const subject = 'Business Inquiry — Let\'s Work Together';

              // Direct Gmail Web Compose URL — no mailto, no protocol handler, no Chrome dialog
              final gmailComposeUrl =
                  'https://mail.google.com/mail/u/0/?view=cm&fs=1'
                  '&to=${Uri.encodeComponent(contact.email)}'
                  '&su=${Uri.encodeComponent(subject)}';

              Get.find<PortfolioController>().trackAction('contact_email_click');
              Get.snackbar(
                'Opening Gmail Compose…',
                'Sending to ${contact.email}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );

              if (kIsWeb) {
                web_utils.openWindow(gmailComposeUrl, '_blank');
              } else {
                // Native: fall back to mailto for iOS/Android/Desktop mail clients
                launchUrl(Uri(
                  scheme: 'mailto',
                  path: contact.email,
                  queryParameters: {'subject': subject},
                ));
              }
            } : null,
          ),
          AreaInfoText(
            title: 'Phone', 
            icon: Icons.phone_iphone_rounded,
            text: contact.phone.isNotEmpty ? contact.phone : 'Not Available',
            onTap: contact.phone.isNotEmpty ? () {
              Get.find<PortfolioController>().trackAction('contact_phone_click');
              launchUrl(Uri.parse('tel:${contact.phone}'));
            } : null,
          ),
          AreaInfoText(
            title: 'LinkedIn', 
            icon: Icons.link_rounded,
            text: social.linkedin.isNotEmpty ? 'linkedin.com/in/crealify' : 'Not Available',
            copyText: social.linkedin.isNotEmpty ? social.linkedin : null,
            onTap: social.linkedin.isNotEmpty ? () {
               Get.snackbar('LinkedIn', 'Opening Profile...', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white.withValues(alpha: 0.1), colorText: Colors.white);
               launchUrl(Uri.parse(social.linkedin), mode: LaunchMode.externalApplication);
            } : null,
          ),
          AreaInfoText(
            title: 'Github', 
            icon: Icons.code_rounded,
            text: social.github.isNotEmpty ? 'github.com/Crealify' : 'Not Available',
            copyText: social.github.isNotEmpty ? social.github : null,
            onTap: social.github.isNotEmpty ? () {
               Get.snackbar('GitHub', 'Opening Repository...', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white.withValues(alpha: 0.1), colorText: Colors.white);
               launchUrl(Uri.parse(social.github), mode: LaunchMode.externalApplication);
            } : null,
          ),
          const SizedBox(
            height: spacing12,
          ),
          const Text(
            'Technical Skills',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      );
    });
  }
}

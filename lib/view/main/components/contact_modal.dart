import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';

/// A bottom sheet modal offering multiple communication channels.
class ContactModal extends StatelessWidget {
  const ContactModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cc = Get.find<PortfolioController>().contactConfig.value;
      final sc = Get.find<PortfolioController>().socialConfig.value;
      
      return Container(
        padding: const EdgeInsets.all(AppConstants.spacing24),
        decoration: const BoxDecoration(
          color: AppConstants.bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Grab Handle ---
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppConstants.spacing24),
            
            Text(
              "Let's Work Together",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacing8),
            const Text(
              "Choose your preferred way to connect",
              style: TextStyle(color: AppConstants.bodyTextColor),
            ),
            const SizedBox(height: AppConstants.spacing40),
            
            _ContactTile(
              title: 'Email Me',
              subtitle: cc.email,
              iconWidget: const Icon(Icons.email_outlined, color: Colors.blue, size: 24),
              color: Colors.blue,
              onTap: () async {
                const subject = 'Business Inquiry';
                final mailtoUrl = Uri(
                  scheme: 'mailto',
                  path: cc.email,
                  queryParameters: {
                    'subject': subject,
                  },
                );
                final gmailUrl = Uri(
                  scheme: 'https',
                  host: 'mail.google.com',
                  path: '/mail/u/0/',
                  queryParameters: {
                    'to': cc.email,
                    'su': subject,
                    'fs': '1',
                    'tf': 'cm',
                  },
                );
                if (!await launchUrl(mailtoUrl)) {
                  await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
                }
              },
              isPrimary: !Responsive.isMobile(context),
            ),
            if (sc.linkedin.isNotEmpty) ...[
              const SizedBox(height: AppConstants.spacing16),
              _ContactTile(
                title: 'LinkedIn',
                subtitle: sc.linkedin.replaceFirst(RegExp(r'^https?://(www\.)?'), ''),
                iconWidget: const FaIcon(FontAwesomeIcons.linkedinIn, color: Color(0xFF0077B5), size: 24),
                color: const Color(0xFF0077B5),
                onTap: () => launchUrl(Uri.parse(sc.linkedin), mode: LaunchMode.externalApplication),
              ),
            ],
            if (cc.phone.isNotEmpty) ...[
              const SizedBox(height: AppConstants.spacing16),
              _ContactTile(
                title: 'WhatsApp',
                subtitle: cc.phone,
                iconWidget: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366), size: 24),
                color: const Color(0xFF25D366),
                onTap: () => launchUrl(Uri.parse('https://wa.me/${cc.phone.replaceAll(RegExp(r'[^0-9+]'), '')}'), mode: LaunchMode.externalApplication),
                isPrimary: Responsive.isMobile(context),
              ),
            ],
            const SizedBox(height: AppConstants.spacing40),
          ],
        ),
      );
    });
  }
}

class _ContactTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget iconWidget;
  final Color color;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ContactTile({
    required this.title,
    required this.subtitle,
    required this.iconWidget,
    required this.color,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        decoration: BoxDecoration(
          color: AppConstants.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isPrimary ? Border.all(color: color.withValues(alpha: 0.5), width: 2) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: iconWidget,
            ),
            const SizedBox(width: AppConstants.spacing16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppConstants.bodyTextColor, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
          ],
        ),
      ),
    );
  }
}

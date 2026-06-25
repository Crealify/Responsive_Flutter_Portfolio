import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../../res/constants.dart';

class ContactIcon extends StatelessWidget {
  const ContactIcon({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 20.0; // Small uniform size

    return Obx(() {
      final sc = Get.find<PortfolioController>().socialConfig.value;
      return Container(
        margin: const EdgeInsets.only(top: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (sc.linkedin.isNotEmpty)
              _SocialIconButton(
                url: sc.linkedin,
                iconPath: 'assets/icons/linkedin.svg',
                size: iconSize,
              ),
            if (sc.github.isNotEmpty)
              _SocialIconButton(
                url: sc.github,
                iconPath: 'assets/icons/github.svg',
                size: iconSize,
              ),
            if (sc.facebook.isNotEmpty)
              _SocialIconButton(
                url: sc.facebook,
                iconPath: 'assets/icons/facebook.svg',
                size: iconSize,
              ),
            if (sc.instagram.isNotEmpty)
              _SocialIconButton(
                url: sc.instagram,
                iconPath: 'assets/icons/instagram.svg',
                size: iconSize,
              ),
            if (sc.youtube.isNotEmpty)
              _SocialIconButton(
                url: sc.youtube,
                iconPath: 'assets/icons/youtube.svg',
                size: iconSize,
              ),
          ],
        ),
      );
    });
  }
}

class _SocialIconButton extends StatefulWidget {
  final String url;
  final String iconPath;
  final double size;

  const _SocialIconButton({
    required this.url,
    required this.iconPath,
    required this.size,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isHovered ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: IconButton(
        onPressed: () {
          Get.find<PortfolioController>().trackAction('social_click_${widget.url.split('.').reversed.elementAt(1)}');
          launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication);
        },
        onHover: (value) => setState(() => _isHovered = value),
        icon: SvgPicture.asset(
          widget.iconPath,
          height: widget.size,
          colorFilter: ColorFilter.mode(
            _isHovered ? AppConstants.primaryColor : Colors.white.withValues(alpha: 0.8),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

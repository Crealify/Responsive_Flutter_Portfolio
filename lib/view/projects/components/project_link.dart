import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

import '../../../res/constants.dart';

class ProjectLinks extends StatelessWidget {
  final int index;
  const ProjectLinks({super.key, required this.index});

  bool get _isAppStore =>
      Get.find<PortfolioController>().projects[index].link.contains('apps.apple.com') ||
      Get.find<PortfolioController>().projects[index].link.contains('play.google.com');

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _isAppStore ? 'View on App Store' : 'Check on Github',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () {
                final proj = Get.find<PortfolioController>().projects[index];
                Get.find<PortfolioController>().trackAction('project_link_click_${proj.name}');
                launchUrl(
                    Uri.parse(proj.link),
                    mode: LaunchMode.externalApplication);
              },
              icon: _isAppStore
                  ? const Icon(Icons.apple, color: Colors.white, size: 20)
                  : SvgPicture.asset(
                      'assets/icons/github.svg', colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            final proj = Get.find<PortfolioController>().projects[index];
            Get.find<PortfolioController>().trackAction('project_read_more_${proj.name}');
            launchUrl(Uri.parse(proj.link));
          },
          child: Text(
            _isAppStore ? 'Open ›' : 'Read More ››',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

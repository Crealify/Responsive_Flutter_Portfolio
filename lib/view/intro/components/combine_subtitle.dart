import 'package:anilbhattarai_portfolio/view/intro/components/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

import '../../../view_model/responsive.dart';

class CombineSubtitleText extends StatelessWidget {
  const CombineSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hc = Get.find<PortfolioController>().heroConfig.value;
      return Wrap(
        alignment: WrapAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8B5CF6),
                  Color(0xFF06B6D4),
                ],
              ).createShader(bounds);
            },
            child: Responsive(
              desktop: AnimatedSubtitleText(start: 40, end: 50, text: hc.title, gradient: false),
              largeMobile: AnimatedSubtitleText(start: 25, end: 28, text: hc.title, gradient: false),
              mobile: AnimatedSubtitleText(start: 18, end: 22, text: hc.title, gradient: true),
              tablet: AnimatedSubtitleText(start: 30, end: 35, text: hc.title, gradient: false),
            ),
          )
        ],
      );
    });
  }
}

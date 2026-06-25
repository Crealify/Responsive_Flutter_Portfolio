import 'package:anilbhattarai_portfolio/view/certifications/certifications.dart';
import 'package:anilbhattarai_portfolio/view/educations/educations.dart';
import 'package:anilbhattarai_portfolio/view/experience/experiences.dart';

import 'package:anilbhattarai_portfolio/view/intro/introduction.dart';
import 'package:anilbhattarai_portfolio/view/main/main_view.dart';
import 'package:anilbhattarai_portfolio/view/projects/project_view.dart';
import 'package:anilbhattarai_portfolio/view/tech_stack/tech_stack.dart';
import 'package:anilbhattarai_portfolio/view/feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/getx_controllers/portfolio_controller.dart';
import '../../res/components/custom_error_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<PortfolioController>();
      if (controller.hasNetworkError.value) {
        return CustomErrorScreen(
          onRefresh: () {
            controller.loadAll();
          },
        );
      }

      return const MainView(
        pages: [
          Introduction(),
          Experiences(),
          ProjectsView(),
          TechStackView(),
          Educations(),
          Certifications(),
          // AwardsView(), // Hidden for now, needed in future
          ClientFeedback(),
        ],
      );
    });
  }
}

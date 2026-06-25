import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import 'feedback_card.dart';

/// Renders a dynamic Grid/Wrap of client feedback cards with slide entry effects.
class FeedbackGrid extends StatelessWidget {
  const FeedbackGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<PortfolioController>();
      final clients = controller.clients;

      if (clients.isEmpty) return const SizedBox.shrink();

      return LayoutBuilder(builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final bool isDesktop = Responsive.isDesktop(context);
        const double gap = AppConstants.spacing24;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: clients.asMap().entries.map((entry) {
              final index = entry.key;
              final client = entry.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < clients.length - 1 ? gap : 0,
                  ),
                  child: FeedbackCard(
                    name: client.name,
                    role: client.role,
                    feedback: client.feedback,
                    rating: client.rating,
                    isEqualHeight: false,
                  ).animate(delay: (index * 150).ms).fadeIn().slideY(begin: 0.1),
                ),
              );
            }).toList(),
          );
        }

        // Calculate dynamic width for mobile / tablet Wrap
        int crossAxisCount = 1;
        if (Responsive.isTablet(context)) {
          crossAxisCount = 2;
        }
        final double cardWidth = (availableWidth - (crossAxisCount - 1) * gap) / crossAxisCount;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: clients.asMap().entries.map((entry) {
            final index = entry.key;
            final client = entry.value;
            return FeedbackCard(
              name: client.name,
              role: client.role,
              feedback: client.feedback,
              rating: client.rating,
              width: cardWidth,
              isEqualHeight: false,
            ).animate(delay: (index * 150).ms).fadeIn().slideY(begin: 0.1);
          }).toList(),
        );
      });
    });
  }
}

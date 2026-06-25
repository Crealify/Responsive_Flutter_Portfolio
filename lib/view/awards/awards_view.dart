import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/getx_controllers/portfolio_controller.dart';
import '../../view_model/responsive.dart';
import '../../res/constants.dart';
import '../../res/components/section_header.dart';
import '../../res/components/scroll_reveal.dart';
import 'components/award_card.dart';

class AwardsView extends StatelessWidget {
  const AwardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'Awards &', title: 'Publications'),
        const SizedBox(height: AppConstants.spacing40),
        Obx(() {
          final awards = controller.awards;
          if (awards.isEmpty) return const SizedBox.shrink();

          return LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = Responsive.isMobile(context);
              final bool isTablet = Responsive.isTablet(context);
              
              int crossAxisCount = 3;
              if (isMobile) {
                crossAxisCount = 1;
              } else if (isTablet || constraints.maxWidth < 900) {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.4 : 1.2,
                ),
                itemCount: awards.length,
                itemBuilder: (context, index) {
                  final award = awards[index];
                  // Cycling through premium neon colors
                  final colors = [
                    const Color(0xFF00FFD2),
                    const Color(0xFFFF00A0),
                    const Color(0xFF9B5FFE),
                  ];
                  final accent = colors[index % colors.length];

                  return ScrollReveal(
                    baseKey: 'award',
                    index: index,
                    delay: Duration(milliseconds: index * 100),
                    child: AwardCard(award: award, accentColor: accent),
                  );
                },
              );
            },
          );
        }),
      ],
    );
  }
}

import 'package:anilbhattarai_portfolio/res/components/premium_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../res/constants.dart';
import '../../../res/components/section_header.dart';
import 'package:anilbhattarai_portfolio/view_model/responsive.dart';
import 'package:anilbhattarai_portfolio/view_model/getx_controllers/portfolio_controller.dart';
import 'package:get/get.dart';
import 'short_card.dart';

/// A vertically-oriented showcase for YouTube Shorts and mobile-first video content.
class ShortsVibes extends StatelessWidget {
  const ShortsVibes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(prefix: 'Shorts ', title: 'Vibes'),
        SizedBox(height: AppConstants.spacing24),
        _ShortsGrid(),
        SizedBox(height: AppConstants.spacing40),
      ],
    );
  }
}

class _ShortsGrid extends StatefulWidget {
  const _ShortsGrid();

  @override
  State<_ShortsGrid> createState() => _ShortsGridState();
}

class _ShortsGridState extends State<_ShortsGrid> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double availableWidth = constraints.maxWidth;
      
      int crossAxisCount = 2;
      if (Responsive.isDesktop(context)) {
        crossAxisCount = 6;
      } else if (Responsive.isTablet(context)) {
        crossAxisCount = 4;
      } else if (Responsive.isLargeMobile(context)) {
        crossAxisCount = 3;
      }
      
      const double gap = AppConstants.spacing16;
      final double cardWidth = (availableWidth - (crossAxisCount - 1) * gap) / crossAxisCount;

      return Obx(() {
        final controller = Get.find<PortfolioController>();
        final allShorts = controller.shorts;
        
        if (allShorts.isEmpty) return const SizedBox.shrink();

        final bool isMobile = Responsive.isMobile(context);
        final displayedShorts = _showAll ? allShorts : (isMobile ? allShorts : allShorts.take(6).toList());

        if (isMobile && !_showAll) {
          // Horizontal scrolling for mobile (2 cards visible)
          final double mobileCardWidth = (availableWidth - gap) / 2.1; // 2.1 to show a bit of the next card
          return SizedBox(
            height: (mobileCardWidth * 16/9) + 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: allShorts.length,
              separatorBuilder: (context, index) => const SizedBox(width: gap),
              itemBuilder: (context, index) {
                final short = allShorts[index];
                return ShortCard(
                  key: ValueKey(short.id),
                  short: short,
                  width: mobileCardWidth,
                ).animate(delay: (index * 100).ms).fadeIn().scale(begin: const Offset(0.8, 0.8));
              },
            ),
          );
        }

        return Column(
          children: [
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: displayedShorts.asMap().entries.map((entry) {
                final index = entry.key;
                final short = entry.value;
                return ShortCard(
                  key: ValueKey(short.id),
                  short: short,
                  width: cardWidth,
                ).animate(delay: (index * 100).ms).fadeIn().scale(begin: const Offset(0.8, 0.8));
              }).toList(),
            ),
            const SizedBox(height: AppConstants.spacing24),
            if (allShorts.length > 6 || (isMobile && !_showAll))
              Center(
                child: PremiumButton(
                  text: _showAll ? "Show Less" : "View More Vibes",
                  onTap: () => setState(() => _showAll = !_showAll),
                  icon: _showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
              ),
          ],
        );
      });
    });
  }
}

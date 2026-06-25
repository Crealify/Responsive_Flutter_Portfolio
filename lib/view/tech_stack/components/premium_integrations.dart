import 'package:flutter/material.dart';
import 'package:anilbhattarai_portfolio/view_model/responsive.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../tech_data.dart';
import 'premium_integration_card.dart';

class PremiumIntegrationsSection extends StatelessWidget {
  const PremiumIntegrationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final double width = MediaQuery.sizeOf(context).width;
    final int crossAxisCount = width < 600 ? 1 : (width < 1000 ? 2 : 3);

    return SizedBox(
      width: double.infinity,
      child: StaggeredGrid.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 30,
        crossAxisSpacing: 20,
        children: TechData.premiumIntegrations.asMap().entries.map((entry) {
          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: PremiumIntegrationCard(
                skill: entry.value, index: entry.key, isDesktop: isDesktop),
          );
        }).toList(),
      ),
    );
  }
}

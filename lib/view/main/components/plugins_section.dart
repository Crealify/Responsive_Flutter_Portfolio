import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/components/responsive_grid.dart';
import '../../../../res/components/section_header.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/constants.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../../view_model/responsive.dart';
import '../../projects/components/plugin_info.dart';

class PluginsSection extends StatelessWidget {
  const PluginsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'PACKAGES &', title: 'PLUGINS'),
        const SizedBox(height: AppConstants.spacing40),
        
        Obx(() {
          final plugins = controller.plugins;

          if (plugins.isEmpty) return const SizedBox.shrink();

          if (plugins.length < 3) {
            final double screenWidth = MediaQuery.sizeOf(context).width;
            final bool isMobile = screenWidth < 700;
            return Center(
              child: Wrap(
                spacing: AppConstants.spacing16,
                runSpacing: AppConstants.spacing16,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(plugins.length, (index) {
                  return SizedBox(
                    width: isMobile ? double.infinity : 380,
                    child: PluginStack(index: index)
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .scale(begin: const Offset(0.9, 0.9)),
                  );
                }),
              ),
            );
          }

          return Responsive(
            desktop: _buildPluginGrid(3, 1.7, plugins),
            extraLargeScreen: _buildPluginGrid(4, 1.8, plugins),
            tablet: _buildPluginGrid(2, 1.8, plugins),
            largeMobile: _buildPluginGrid(1, 2.0, plugins),
            mobile: _buildPluginGrid(1, 1.9, plugins),
          );
        }),
      ],
    );
  }

  Widget _buildPluginGrid(int count, double ratio, List plugins) {
    return ResponsiveGrid(
      itemCount: plugins.length,
      crossAxisCount: count,
      ratio: ratio,
      itemBuilder: (context, index) {
        return PluginStack(index: index)
            .animate()
            .fadeIn(duration: 800.ms)
            .scale(begin: const Offset(0.9, 0.9));
      },
    );
  }
}

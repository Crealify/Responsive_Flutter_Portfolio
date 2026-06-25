import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/section_header.dart';
import '../../view_model/getx_controllers/portfolio_controller.dart';
import '../../view_model/responsive.dart';
import '../../res/constants.dart';
import '../../res/components/pagination_strips.dart';
import 'components/desktop_education_tree.dart';
import 'components/mobile_education_timeline.dart';

/// A creative, ultra-premium academic timeline/tree branch structure.
/// - alternated cyber-cyan and hot-pink branches
/// - horizontal neon-gradient trunk branch connectors
/// - holographic pulsating & rotating central milestones
/// - active path highlighting triggered dynamically by card hovers
class Educations extends StatefulWidget {
  const Educations({super.key});

  @override
  State<Educations> createState() => _EducationsState();
}

class _EducationsState extends State<Educations> with SingleTickerProviderStateMixin {
  final ValueNotifier<int> _hoveredIndexNotifier = ValueNotifier<int>(-1);
  int _visibleCount = 3;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _hoveredIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'My', title: 'Educations'),
        const SizedBox(height: AppConstants.spacing40),
        
        Obx(() {
          final educationData = controller.educations;
          if (educationData.isEmpty) return const SizedBox.shrink();

          final int hiddenCount = (educationData.length - _visibleCount).clamp(0, 999);
          final List<dynamic> displayedData = educationData.take(_visibleCount).toList();

          return Column(
            children: [
              Responsive.isDesktop(context)
                  ? DesktopEducationTree(
                      educations: displayedData,
                      hoveredIndexNotifier: _hoveredIndexNotifier,
                    )
                  : MobileEducationTimeline(
                      educations: displayedData,
                      hoveredIndexNotifier: _hoveredIndexNotifier,
                    ),
              if (educationData.length > 3) ...[
                const SizedBox(height: AppConstants.spacing24),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: _visibleCount >= educationData.length
                      ? CollapseStrip(onTap: () => setState(() => _visibleCount = 3))
                      : RevealStrip(
                          hiddenCount: hiddenCount,
                          shimmerController: _shimmerController,
                          onTap: () => setState(() => _visibleCount += 3),
                          itemName: 'education',
                        ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }
}

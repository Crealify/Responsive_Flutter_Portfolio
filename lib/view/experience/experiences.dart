import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/section_header.dart';
import '../../res/components/pagination_strips.dart';
import '../../view_model/getx_controllers/portfolio_controller.dart';
import '../../view_model/responsive.dart';
import '../../res/constants.dart';
import 'components/desktop_experience_tree.dart';
import 'components/mobile_experience_timeline.dart';

/// Premium center-axis timeline tree for Experiences & Training.
/// Desktop: alternating left/right cards around a glowing center spine.
/// Mobile: left-spine with branching cards.
class Experiences extends StatefulWidget {
  const Experiences({super.key});

  @override
  State<Experiences> createState() => _ExperiencesState();
}

class _ExperiencesState extends State<Experiences> with SingleTickerProviderStateMixin {
  final ValueNotifier<int> _hoveredIndex = ValueNotifier<int>(-1);
  int _visibleCount = 3;
  late AnimationController _shimmerController;

  // Cycling accent colors per card index
  static const List<Color> _accents = [
    Color(0xFF00FFD2), // cyber cyan
    Color(0xFFFF00A0), // neon pink
    Color(0xFF9B5FFE), // electric violet
    Color(0xFFFFA640), // amber gold
  ];

  Color _accentFor(int i) => _accents[i % _accents.length];

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
    _hoveredIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'Experiences &', title: 'Training'),
        const SizedBox(height: AppConstants.spacing40),

        Obx(() {
          final expData = controller.experiences;
          if (expData.isEmpty) return const SizedBox.shrink();

          final int hiddenCount = (expData.length - _visibleCount).clamp(0, 999);
          final List<dynamic> displayedData = expData.take(_visibleCount).toList();

          return Column(
            children: [
              Responsive.isDesktop(context)
                  ? DesktopExperienceTree(
                      exps: displayedData,
                      hoveredIndex: _hoveredIndex,
                      accentFor: _accentFor,
                    )
                  : MobileExperienceTimeline(
                      exps: displayedData,
                      hoveredIndex: _hoveredIndex,
                      accentFor: _accentFor,
                    ),
              if (expData.length > 3) ...[
                const SizedBox(height: AppConstants.spacing24),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: _visibleCount >= expData.length
                      ? CollapseStrip(onTap: () => setState(() => _visibleCount = 3))
                      : RevealStrip(
                          hiddenCount: hiddenCount,
                          shimmerController: _shimmerController,
                          onTap: () => setState(() => _visibleCount += 3),
                          itemName: 'experience',
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

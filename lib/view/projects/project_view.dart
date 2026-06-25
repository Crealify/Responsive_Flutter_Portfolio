import 'package:anilbhattarai_portfolio/res/components/section_header.dart';
import 'package:anilbhattarai_portfolio/view/projects/components/project_info.dart';
import 'package:anilbhattarai_portfolio/view_model/getx_controllers/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../model/project_model.dart';
import '../../res/constants.dart';
import '../../res/components/pagination_strips.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView>
    with SingleTickerProviderStateMixin {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'Latest', title: 'Projects'),
        const SizedBox(height: AppConstants.spacing40),
        Obx(() {
          if (controller.isProjectsLoading.value &&
              controller.projects.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing48),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Center(
                        child: Icon(Icons.code_rounded, color: Colors.white.withValues(alpha: 0.3)),
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                     .fade(begin: 0.4, end: 1.0, duration: 800.ms)
                     .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1)),
                    const SizedBox(height: 24),
                    Text(
                      'COMPILING PROJECTS...',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontFamily: 'Outfit',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                     .fade(begin: 0.3, end: 0.8, duration: 800.ms),
                  ],
                ),
              ),
            );
          }

          final double width = MediaQuery.sizeOf(context).width;
          final int crossAxisCount = width < 600 ? 1 : (width < 1000 ? 2 : 3);

          final allProjects = controller.projects;
          final int hiddenCount = (allProjects.length - _visibleCount).clamp(0, 999);
          final List<Project> displayedProjects = allProjects.take(_visibleCount).toList();

          return Column(
            children: [
              // --- Project Grid with optional gradient curtain ---
              Stack(
                children: [
                  // The actual grid
                  StaggeredGrid.count(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: AppConstants.spacing24,
                    crossAxisSpacing: AppConstants.spacing24,
                    children: List.generate(displayedProjects.length, (index) {
                      return StaggeredGridTile.fit(
                        crossAxisCellCount: 1,
                        child: ProjectStack(index: index)
                            .animate(delay: (index * 100).ms)
                            .fadeIn(duration: 800.ms)
                            .scale(
                                begin: const Offset(0.8, 0.8),
                                curve: Curves.easeOutBack),
                      );
                    }),
                  ),

                ],
              ),

              // --- Reveal Strip ---
              if (allProjects.length > 3) ...[
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: _visibleCount >= allProjects.length
                      ? CollapseStrip(onTap: () => setState(() => _visibleCount = 3))
                      : RevealStrip(
                          hiddenCount: hiddenCount,
                          shimmerController: _shimmerController,
                          onTap: () => setState(() => _visibleCount += 3),
                          itemName: 'project',
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



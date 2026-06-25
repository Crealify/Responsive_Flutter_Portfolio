import 'package:flutter/material.dart';
import '../../../../res/constants.dart';
import '../../../../view_model/controller.dart';

import 'portfolio_ending.dart';
import 'featured_videos.dart';
import 'college_memories.dart';
import 'plugins_section.dart';
import 'section_divider.dart';
import 'dynamic_section.dart';
import 'premium_smooth_scroll.dart';

class MainScrollContent extends StatelessWidget {
  final List<Widget> pages;
  final bool isDesktop;
  final bool isLarge;

  const MainScrollContent({
    super.key,
    required this.pages,
    required this.isDesktop,
    required this.isLarge,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      _buildSection(AppController.homeKey, pages[0], 'home'),
      SectionDivider(isDesktop: isDesktop),
      _buildSection(AppController.experienceKey, pages[1], 'experience'),
      SectionDivider(isDesktop: isDesktop),
      _buildSection(AppController.projectsKey, pages[2], 'projects'),
      SectionDivider(isDesktop: isDesktop),
      _buildSection(AppController.techStackKey, pages[3], 'tech_stack'),
      SectionDivider(isDesktop: isDesktop),
      _buildSection(AppController.educationKey, pages[4], 'education'),
      SectionDivider(isDesktop: isDesktop),
      _buildSection(AppController.certificationsKey, pages[5], 'certifications'),
      SectionDivider(isDesktop: isDesktop),
      const NamedSection(name: 'plugins', child: PluginsSection()),
      SectionDivider(isDesktop: isDesktop),
      const NamedSection(name: 'videos', child: FeaturedVideos()),
      SectionDivider(isDesktop: isDesktop),
      const NamedSection(name: 'memories', child: CollegeMemories()),
      SectionDivider(isDesktop: isDesktop),
      NamedSection(name: 'feedback', child: pages[6]),
      SizedBox(height: isDesktop ? 60 : 40),
      const PortfolioEnding(),
      if (!isDesktop) const SizedBox(height: 100),
    ];

    return PremiumSmoothScroll(
      controller: globalScrollController,
      builder: (context, physics) {
        return CustomScrollView(
          key: const PageStorageKey('main_portfolio_list'),
          controller: globalScrollController,
          physics: physics,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: List.generate(sections.length, (index) {
                  final sectionWidget = sections[index];
                  final isFirst = index == 0;
                  return Center(
                    child: RepaintBoundary(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isLarge
                              ? 1440
                              : (appController.isMenuOpen.value ? 1100 : 1200),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: isFirst
                                ? (isDesktop
                                    ? 80
                                    : (MediaQuery.sizeOf(context).height * 0.12).clamp(90, 120))
                                : 0,
                          ),
                          child: (sectionWidget is SectionDivider)
                              ? sectionWidget
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: (sectionWidget is PortfolioEnding)
                                        ? 0
                                        : (MediaQuery.sizeOf(context).width < 600
                                            ? AppConstants.spacing16
                                            : (MediaQuery.sizeOf(context).width < 1200
                                                ? AppConstants.spacing32
                                                : (isLarge
                                                    ? AppConstants.spacing64
                                                    : AppConstants.spacing48))),
                                  ),
                                  child: (sectionWidget is NamedSection)
                                      ? DynamicSection(
                                          index: index,
                                          animKey: 'section_anim_$index',
                                          sectionName: sectionWidget.name,
                                          sectionKey: sectionWidget.key as GlobalKey?,
                                          child: sectionWidget.child,
                                        )
                                      : DynamicSection(
                                          index: index,
                                          animKey: 'section_anim_$index',
                                          sectionName: 'divider_$index',
                                          child: sectionWidget,
                                        ),
                                ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSection(GlobalKey key, Widget child, String name) {
    return NamedSection(name: name, key: key, child: child);
  }
}

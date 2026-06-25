import 'package:anilbhattarai_portfolio/res/constants.dart';
import 'package:anilbhattarai_portfolio/view_model/controller.dart';
import 'package:anilbhattarai_portfolio/view/main/components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/responsive.dart';
import 'components/drawer/drawer.dart';
import '../../res/components/mesh_background.dart';
import 'components/scroll_to_top_button.dart';
import 'components/main_bottom_nav.dart';
import 'components/main_scroll_content.dart';

/// The primary layout shell for the portfolio website.
class MainView extends StatelessWidget {
  const MainView({super.key, required this.pages});

  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isLarge = Responsive.isExtraLargeScreen(context);

    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      drawer: isDesktop ? null : const CustomDrawer(),
      bottomNavigationBar: null,
      body: SafeArea(
        bottom: false,
        child: MouseRegion(
          cursor: MouseCursor.defer,
          child: Row(
            children: [
              // --- Desktop collapsible sidebar ---
              if (isDesktop)
                Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      width: appController.isMenuOpen.value
                          ? (isLarge ? 320 : 280)
                          : 0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          if (appController.isMenuOpen.value)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          width: isLarge ? 320 : 280,
                          child: const CustomDrawer(),
                        ),
                      ),
                    )),

              // --- Main content area ---
              Expanded(
                child: Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      margin: appController.isMenuOpen.value
                          ? const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 16)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: AppConstants.bgColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(appController.isMenuOpen.value ? 24 : 0),
                        ),
                        boxShadow: [
                          if (appController.isMenuOpen.value)
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.04),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(appController.isMenuOpen.value ? 24 : 0),
                        ),
                        child: Stack(
                          children: [
                            if (isDesktop) const RepaintBoundary(child: MeshBackground()),
                            Builder(builder: (context) {
                              return MainScrollContent(
                                pages: pages,
                                isDesktop: isDesktop,
                                isLarge: isLarge,
                              );
                            }),
                            // --- Floating glassmorphic header ---
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Obx(() => AnimatedSlide(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOutCubic,
                                    offset: appController.isHeaderVisible.value
                                        ? Offset.zero
                                        : const Offset(0, -1.5),
                                    child: SafeArea(
                                      bottom: false,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: const RepaintBoundary(child: TopNavigationBar()),
                                      ),
                                    ),
                                  )),
                            ),
                            // --- Scroll to Top FAB ---
                            Positioned(
                              bottom: isDesktop ? 40 : 20,
                              right: isDesktop ? 40 : 16,
                              child: Obx(() => AnimatedScale(
                                    duration: const Duration(milliseconds: 500),
                                    scale: !appController.isNavbarVisible.value ? 1.0 : 0.0,
                                    curve: Curves.easeOutBack,
                                    child: const ScrollToTopButton(),
                                  )),
                            ),
                            // --- Mobile Floating Bottom Nav ---
                            if (!isDesktop)
                              const Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: MainBottomNav(),
                              ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

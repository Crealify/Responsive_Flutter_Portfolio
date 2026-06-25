import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';
import '../../../view_model/controller.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Obx(() => AnimatedSlide(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            offset: appController.isNavbarVisible.value
                ? Offset.zero
                : const Offset(0, 1.5),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ── Outer glow halo ──
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withValues(alpha: 0.18),
                                blurRadius: 32,
                                spreadRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.85),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ── Glass pill ──
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF0D1829).withValues(alpha: 0.96),
                                    const Color(0xFF07101E).withValues(alpha: 0.99),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.cyanAccent.withValues(alpha: 0.22),
                                  width: 1.2,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    right: 20,
                                    height: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.cyanAccent.withValues(alpha: 0.6),
                                            Colors.transparent,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ── Animated Notch Bottom Bar ──
                      AnimatedNotchBottomBar(
                        notchBottomBarController: appController.notchBottomBarController,
                        color: Colors.transparent,
                        notchColor: Colors.cyanAccent,
                        showLabel: true,
                        bottomBarHeight: 60.0,
                        removeMargins: true,
                        itemLabelStyle: const TextStyle(
                          color: Colors.white60,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                        bottomBarItems: [
                          BottomBarItem(
                            inActiveItem: const Icon(Icons.home_outlined, color: Colors.white38, size: 22),
                            activeItem: const Icon(Icons.home_rounded, color: Colors.black, size: 22),
                            itemLabel: 'Home',
                          ),
                          BottomBarItem(
                            inActiveItem: const Icon(Icons.badge_outlined, color: Colors.white38, size: 22),
                            activeItem: const Icon(Icons.badge_rounded, color: Colors.black, size: 22),
                            itemLabel: 'Experience',
                          ),
                          BottomBarItem(
                            inActiveItem: const Icon(Icons.work_outline_rounded, color: Colors.white38, size: 22),
                            activeItem: const Icon(Icons.work_rounded, color: Colors.black, size: 22),
                            itemLabel: 'Projects',
                          ),
                          BottomBarItem(
                            inActiveItem: const Icon(Icons.code_outlined, color: Colors.white38, size: 22),
                            activeItem: const Icon(Icons.code_rounded, color: Colors.black, size: 22),
                            itemLabel: 'Tech',
                          ),
                          BottomBarItem(
                            inActiveItem: const Icon(Icons.school_outlined, color: Colors.white38, size: 22),
                            activeItem: const Icon(Icons.school_rounded, color: Colors.black, size: 22),
                            itemLabel: 'Education',
                          ),
                        ],
                        onTap: (index) {
                          appController.notchBottomBarController.jumpTo(index);
                          switch (index) {
                            case 0:
                              appController.scrollToSection(AppController.homeKey);
                              break;
                            case 1:
                              appController.scrollToSection(AppController.experienceKey);
                              break;
                            case 2:
                              appController.scrollToSection(AppController.projectsKey);
                              break;
                            case 3:
                              appController.scrollToSection(AppController.techStackKey);
                              break;
                            case 4:
                              appController.scrollToSection(AppController.educationKey);
                              break;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

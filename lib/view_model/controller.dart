import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mixins/app_scroll_actions_mixin.dart';

/// Centralized controller managing navigation, scrolling, and global app state.
class AppController extends GetxController with AppScrollActionsMixin {
  // --- Controllers ---
  @override
  late final ScrollController scrollController;
  late final NotchBottomBarController notchBottomBarController;
  
  // --- Observable State ---
  final RxInt currentIndex = 0.obs;
  final RxBool isMenuOpen = false.obs;
  final RxBool isNavbarVisible = true.obs;
  final RxBool isHeaderVisible = true.obs;
  final Rx<GlobalKey?> activeSectionKey = Rx<GlobalKey?>(null);
  double _lastScrollOffset = 0.0;

  // --- Static Registry (Section Keys) ---
  static final GlobalKey homeKey = GlobalKey(debugLabel: 'home_section');
  static final GlobalKey projectsKey = GlobalKey(debugLabel: 'projects_section');
  static final GlobalKey experienceKey = GlobalKey(debugLabel: 'experience_section');
  static final GlobalKey educationKey = GlobalKey(debugLabel: 'education_section');
  static final GlobalKey certificationsKey = GlobalKey(debugLabel: 'certifications_section');
  static final GlobalKey techStackKey = GlobalKey(debugLabel: 'tech_stack_section');

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    notchBottomBarController = NotchBottomBarController(index: 0);
    activeSectionKey.value = homeKey;
    
    // Attach senior-level scroll management
    scrollController.addListener(_onScroll);
  }

  int _lastTraceTime = 0;

  void _onScroll() {
    if (!scrollController.hasClients) return;
    
    final double currentOffset = scrollController.offset;
    final double delta = currentOffset - _lastScrollOffset;
    _lastScrollOffset = currentOffset;

    // Show/hide navbar & header on scroll direction
    if (delta > 5 && currentOffset > 100) {
      if (isNavbarVisible.value) isNavbarVisible.value = false;
      if (isHeaderVisible.value) isHeaderVisible.value = false;
    } else if (delta < -5) {
      if (!isNavbarVisible.value) isNavbarVisible.value = true;
      if (!isHeaderVisible.value) isHeaderVisible.value = true;
    }
    if (currentOffset < 50) {
      if (!isNavbarVisible.value) isNavbarVisible.value = true;
      if (!isHeaderVisible.value) isHeaderVisible.value = true;
    }

    // ── Section tracing: auto-update notch indicator ──
    // Throttled to ~10 times a second to prevent severe localToGlobal jank
    final int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastTraceTime > 100) {
      _lastTraceTime = now;
      _traceActiveSection();
    }
  }

  /// Determines which section is currently visible by checking render positions
  /// relative to a threshold offset, then updates the notch bar indicator.
  void _traceActiveSection() {
    // Trace all 6 key sections including certifications
    final List<GlobalKey> sectionKeys = [
      homeKey,
      experienceKey,
      projectsKey,
      techStackKey,
      educationKey,
      certificationsKey,
    ];

    // Threshold: consider a section "active" when its top is within the top third of screen
    const double threshold = 300.0;
    int bestIndex = 0;
    double bestDy = double.infinity;

    for (int i = 0; i < sectionKeys.length; i++) {
      final ctx = sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final double dy = box.localToGlobal(Offset.zero).dy;
      // The section whose top is closest to (but not below) the threshold wins
      if (dy <= threshold && (threshold - dy) < bestDy) {
        bestDy = threshold - dy;
        bestIndex = i;
      }
    }

    final GlobalKey activeKey = sectionKeys[bestIndex];
    if (activeSectionKey.value != activeKey) {
      activeSectionKey.value = activeKey;
      
      // Update notch controller dynamically (only map sections present on mobile bottom nav)
      final int mobileIndex = _getMobileIndexForKey(activeKey);
      if (currentIndex.value != mobileIndex) {
        currentIndex.value = mobileIndex;
        try {
          notchBottomBarController.jumpTo(mobileIndex);
        } catch (_) {}
      }
    }
  }

  int _getMobileIndexForKey(GlobalKey key) {
    if (key == homeKey) return 0;
    if (key == experienceKey) return 1;
    if (key == projectsKey) return 2;
    if (key == techStackKey) return 3;
    if (key == educationKey) return 4;
    return 0; // Fallback to Home if the section is not present in the mobile bottom nav (e.g., certificationsKey)
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    notchBottomBarController.dispose();
    super.onClose();
  }

  // --- Actions ---



  /// Updates the navigation index based on the currently visible section.
  void updateIndex(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }
}

// Global accessor for convenience
AppController get appController => Get.find<AppController>();
ScrollController get globalScrollController => appController.scrollController;

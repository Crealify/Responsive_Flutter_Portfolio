import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AppScrollActionsMixin on GetxController {
  ScrollController get scrollController;

  /// Smoothly scrolls to a specific section by its GlobalKey, 
  /// accounting for the floating glassmorphic header.
  void scrollToSection(GlobalKey key) {
    try {
      final context = key.currentContext;
      if (context != null && scrollController.hasClients) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          
          double currentOffset = 0;
          try {
            currentOffset = scrollController.offset;
          } catch (_) {
            if (scrollController.positions.isNotEmpty) {
              currentOffset = scrollController.positions.first.pixels;
            }
          }
          
          final double widgetTopOnScreen = box.localToGlobal(Offset.zero).dy;
          final double headerOffset = 110.0; 
          
          double target = currentOffset + widgetTopOnScreen - headerOffset;
          
          // Safety bounds
          double maxScroll = 0;
          try {
            maxScroll = scrollController.position.maxScrollExtent;
          } catch (_) {
            if (scrollController.positions.isNotEmpty) {
              maxScroll = scrollController.positions.first.maxScrollExtent;
            }
          }
          
          if (maxScroll > 0) {
            target = target.clamp(0.0, maxScroll);
          } else {
             target = target < 0 ? 0 : target;
          }
          
          try {
            scrollController.animateTo(
              target,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic,
            );
          } catch (_) {
             if (scrollController.positions.isNotEmpty) {
               scrollController.positions.first.animateTo(
                 target, 
                 duration: const Duration(milliseconds: 1000),
                 curve: Curves.easeInOutCubic,
               );
             }
          }
        }
      }
    } catch (e) {
      debugPrint('Navigation scroll error: $e');
    }
  }

  /// Scrolls back to the very top of the page.
  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}

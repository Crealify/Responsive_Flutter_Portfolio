import 'package:flutter/material.dart';
import 'dart:math' as math;

mixin CollegeMemoriesScrollMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  bool isUserScrolling = false;
  DateTime lastUserScrollTime = DateTime.now();
  bool scrollForward = true;
  final double scrollSpeed = 40.0;
  int hoveredCardsCount = 0;
  bool isAutoScrolling = false;

  void startAutoScroll() {
    if (!scrollController.hasClients) return;
    if (isUserScrolling || hoveredCardsCount > 0) return;
    if (isAutoScrolling) return;
    final position = scrollController.position;
    if (!position.hasContentDimensions) return;
    final double maxScroll = position.maxScrollExtent;
    final double currentScroll = scrollController.offset.clamp(0.0, maxScroll);
    if (maxScroll <= 0) return;
    final double remainingDistance =
        scrollForward ? maxScroll - currentScroll : currentScroll;
    if (remainingDistance <= 0) {
      scrollForward = !scrollForward;
      startAutoScroll();
      return;
    }
    final int durationMs = (remainingDistance / scrollSpeed * 1000).toInt();
    isAutoScrolling = true;
    scrollController
        .animateTo(scrollForward ? maxScroll : 0.0,
            duration: Duration(milliseconds: durationMs), curve: Curves.linear)
        .then((_) {
      isAutoScrolling = false;
      if (mounted && !isUserScrolling && hoveredCardsCount == 0) {
        scrollForward = !scrollForward;
        startAutoScroll();
      }
    });
  }

  void pauseScroll() {
    if (isAutoScrolling && scrollController.hasClients) {
      scrollController.jumpTo(scrollController.offset);
      isAutoScrolling = false;
    }
  }

  void resumeScroll() {
    if (mounted &&
        !isAutoScrolling &&
        !isUserScrolling &&
        hoveredCardsCount == 0) {
      startAutoScroll();
    }
  }

  void onCardHoverChanged(bool isHovered) {
    if (isHovered) {
      hoveredCardsCount++;
      if (hoveredCardsCount == 1) pauseScroll();
    } else {
      hoveredCardsCount = math.max(0, hoveredCardsCount - 1);
      if (hoveredCardsCount == 0) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && hoveredCardsCount == 0) resumeScroll();
        });
      }
    }
  }

  void debounceResume() {
    final resumeTime = DateTime.now();
    lastUserScrollTime = resumeTime;
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted &&
          DateTime.now().difference(lastUserScrollTime).inMilliseconds >=
              1500) {
        isUserScrolling = false;
        resumeScroll();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

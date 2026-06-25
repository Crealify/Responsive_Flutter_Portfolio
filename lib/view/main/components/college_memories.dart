import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors, Matrix4;
import 'dart:math' as math;
import '../../../res/constants.dart';
import '../../../res/components/section_header.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../view_model/responsive.dart';
import 'package:get/get.dart';
import 'memory_card.dart';
import 'vertical_scroll_interceptor.dart';
import 'mixins/college_memories_scroll_mixin.dart';

/// A unique, 3D horizontal gallery for college memories.
class CollegeMemories extends StatefulWidget {
  const CollegeMemories({super.key});

  @override
  State<CollegeMemories> createState() => _CollegeMemoriesState();
}

class _CollegeMemoriesState extends State<CollegeMemories> with CollegeMemoriesScrollMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) startAutoScroll();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'College ', title: 'Memories'),
        const SizedBox(height: AppConstants.spacing40),
        Obx(() {
          final controller = Get.find<PortfolioController>();
          final allMemories = controller.memories;
          if (allMemories.isEmpty) return const SizedBox.shrink();
          return SizedBox(
            height: 330,
            child: Listener(
              onPointerDown: (_) {
                isUserScrolling = true;
                pauseScroll();
              },
              onPointerUp: (_) => debounceResume(),
              onPointerCancel: (_) => debounceResume(),
              onPointerSignal: (pointerSignal) {
                if (pointerSignal is PointerScrollEvent) {
                  isUserScrolling = true;
                  debounceResume();
                }
              },
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad
                  },
                ),
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: Responsive.isDesktop(context)
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  itemCount: allMemories.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacing24),
                  itemBuilder: (context, index) {
                    final memory = allMemories[index];
                    return VerticalScrollInterceptor(
                      child: AnimatedBuilder(
                        animation: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: AppConstants.spacing16),
                          child: MemoryCard(
                              memory: memory,
                              onHoverChanged: onCardHoverChanged),
                        ),
                        builder: (context, child) {
                          double cardPos = 0;
                          if (scrollController.hasClients) {
                            cardPos = (index * 260) - scrollController.offset;
                          }
                          final double screenWidth =
                              MediaQuery.sizeOf(context).width;
                          final double centerDist =
                              (cardPos + 130 - screenWidth / 2);
                          final double absCenterDist = centerDist.abs();
                          final double scale =
                              (1 - (absCenterDist / screenWidth) * 0.25)
                                  .clamp(0.7, 1.0);
                          final double rotation =
                              (centerDist / screenWidth) * 0.5;
                          final double translateY = math.sin((cardPos / 200)) *
                              20.0 *
                              (1 -
                                  (absCenterDist / screenWidth)
                                      .clamp(0.0, 1.0));
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002)
                              ..translateByVector3(
                                  Vector3(0.0, translateY, 0.0))
                              ..scaleByVector3(Vector3(scale, scale, 1.0))
                              ..rotateY(rotation),
                            alignment: Alignment.center,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1);
        }),
      ],
    );
  }
}

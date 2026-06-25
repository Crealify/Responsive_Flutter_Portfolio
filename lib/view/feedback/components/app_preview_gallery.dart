import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import '../../../res/constants.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import 'package:get/get.dart';
import 'gallery_item.dart';
import 'app_preview_gallery_components.dart';

/// An interactive carousel showcasing demo applications with parallax scrolling devices.
class AppPreviewGallery extends StatefulWidget {
  const AppPreviewGallery({super.key});

  @override
  State<AppPreviewGallery> createState() => _AppPreviewGalleryState();
}

class _AppPreviewGalleryState extends State<AppPreviewGallery> {
  PageController? _pageController;
  int _currentPage = 0;
  Timer? _timer;
  final Map<int, ScrollController> _scrollers = {};
  double _lastWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _animateScroller(0);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.sizeOf(context).width;
    if ((width - _lastWidth).abs() > 50) {
      _lastWidth = width;
      // Responsive viewport layout optimized for side-by-side Row format
      final double viewportFraction = width > 1200 ? 0.62 : (width > 800 ? 0.58 : 0.76);
      
      _pageController?.dispose();
      _pageController = PageController(
        viewportFraction: viewportFraction,
        initialPage: _currentPage,
      );
    }
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      final controller = Get.find<PortfolioController>();
      final count = controller.appPreviews.length;
      if (count == 0) return;

      if (_currentPage < count - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController != null && _pageController!.hasClients) {
        _pageController!.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  ScrollController _getScroller(int index) {
    return _scrollers.putIfAbsent(index, () => ScrollController());
  }

  void _animateScroller(int index) {
    final scroller = _getScroller(index);
    if (scroller.hasClients) {
      final max = scroller.position.maxScrollExtent;
      if (max > 0) {
        scroller.animateTo(
          max,
          duration: const Duration(seconds: 8),
          curve: Curves.linear,
        ).then((_) {
          if (mounted && _currentPage == index) {
            scroller.animateTo(0, duration: const Duration(seconds: 2), curve: Curves.easeOut);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var s in _scrollers.values) {
      s.dispose();
    }
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController == null) return const SizedBox.shrink();

    return Obx(() {
      final controller = Get.find<PortfolioController>();
      final apps = controller.appPreviews;

      if (apps.isEmpty) return const SizedBox.shrink();

      return Container(
        height: 520,
        padding: const EdgeInsets.all(AppConstants.spacing32),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F18).withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          boxShadow: [
            BoxShadow(
              color: AppConstants.secondaryColor.withValues(alpha: 0.12), // Complementary Cyan Glow
              blurRadius: 40,
              spreadRadius: -4,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          children: [
            const AppPreviewGalleryHeader(),
            const SizedBox(height: AppConstants.spacing24),
            Expanded(
              child: PageView.builder(
                controller: _pageController!,
                itemCount: apps.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                  _animateScroller(index);
                  Get.find<PortfolioController>().trackAction('app_preview_swipe_${apps[index].name}');
                },
                itemBuilder: (context, index) {
                  final app = apps[index];
                  return AnimatedBuilder(
                    animation: _pageController!,
                    builder: (context, child) {
                      double value = 1.0;
                      double rotateY = 0.0;
                      if (_pageController!.hasClients && _pageController!.position.haveDimensions) {
                        final double page = _pageController!.page ?? _pageController!.initialScrollOffset;
                        value = (1 - ((page - index).abs() * 0.2)).clamp(0.0, 1.0);
                        rotateY = (page - index) * 0.35;
                      } else {
                        value = index == 0 ? 1.0 : 0.8;
                        rotateY = index == 0 ? 0.0 : -0.35;
                      }

                      return Transform(
                        transform: Matrix4.diagonal3Values(value, value, 1.0)
                          ..setEntry(3, 2, 0.0015)
                          ..rotateY(rotateY),
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: value.clamp(0.4, 1.0),
                          child: GalleryItem(
                            app: app,
                            index: index,
                            scrollController: _getScroller(index),
                            onStartAnimateScroller: () => _animateScroller(index),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppConstants.spacing16),
            AppPreviewGalleryIndicator(
              count: apps.length,
              currentPage: _currentPage,
            ),
          ],
        ),
      ).animate().fadeIn(duration: 800.ms);
    });
  }
}

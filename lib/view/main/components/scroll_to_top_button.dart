import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../view_model/controller.dart';
import 'scroll_progress_painter.dart';

/// A premium, stateful Scroll-to-Top FAB component featuring frosted glass,
/// hover-activated upward floating animations, dynamic glows, and sweep border progress indicators.
class ScrollToTopButton extends StatefulWidget {
  const ScrollToTopButton({super.key});

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.12 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedBuilder(
          animation: globalScrollController,
          builder: (context, child) {
            double scrollProgress = 0.0;
            if (globalScrollController.hasClients) {
              try {
                final position = globalScrollController.positions.length == 1
                    ? globalScrollController.position
                    : globalScrollController.positions.first;
                final maxScroll = position.maxScrollExtent;
                final currentScroll = position.pixels;
                if (maxScroll > 0) {
                  scrollProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);
                }
              } catch (_) {}
            }

            return GestureDetector(
              onTap: () => appController.scrollToTop(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Dynamic Progress Border Arc
                  SizedBox(
                    width: 52,
                    height: 52,
                    child: CustomPaint(
                      painter: ScrollProgressPainter(scrollProgress),
                    ),
                  ),
                  // Inner Circle Button (Glassmorphic & Hover Floating)
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isHovered
                              ? const Color(0xFF0C192C).withValues(alpha: 0.85) // Slate glass on hover
                              : const Color(0xFF07111F).withValues(alpha: 0.60), // Frosted glass
                          border: Border.all(
                            color: _isHovered
                                ? const Color(0xFF06B6D4).withValues(alpha: 0.5) // Cyan glow on hover
                                : Colors.white.withValues(alpha: 0.08),
                            width: 1.0,
                          ),
                          boxShadow: [
                            if (_isHovered)
                              BoxShadow(
                                color: const Color(0xFF06B6D4).withValues(alpha: 0.25),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedPadding(
                            padding: EdgeInsets.only(bottom: _isHovered ? 4.0 : 0.0),
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutBack,
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: _isHovered
                                  ? const Color(0xFF06B6D4)
                                  : Colors.white70,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

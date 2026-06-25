import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../../model/award_model.dart';
import '../../../../res/constants.dart';
import 'award_card_content.dart';
import 'award_spotlight.dart';

class AwardCard extends StatefulWidget {
  final AwardModel award;
  final Color accentColor;

  const AwardCard({super.key, required this.award, required this.accentColor});

  @override
  State<AwardCard> createState() => _AwardCardState();
}

class _AwardCardState extends State<AwardCard> {
  bool _isHovered = false;
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    _mousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() {
          _isHovered = false;
          _mousePos.value = Offset.zero;
        }),
        onHover: (e) => _mousePos.value = e.localPosition,
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (widget.award.link.isNotEmpty) {
              launchUrl(Uri.parse(widget.award.link));
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              double normalizedX = 0;
              double normalizedY = 0;

              return ValueListenableBuilder<Offset>(
                valueListenable: _mousePos,
                builder: (context, mousePos, child) {
                  if (_isHovered) {
                    normalizedX = (mousePos.dx / constraints.maxWidth) * 2 - 1;
                    normalizedY = (mousePos.dy / constraints.maxHeight) * 2 - 1;
                  }

                  normalizedX = normalizedX.clamp(-1.0, 1.0);
                  normalizedY = normalizedY.clamp(-1.0, 1.0);

                  return IgnorePointer(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150), // Fast tracking
                      curve: Curves.easeOutCubic,
                      transformAlignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // 3D Perspective
                        ..rotateX(
                            _isHovered ? normalizedY * -0.15 : 0.0) // Tilt up/down
                        ..rotateY(_isHovered
                            ? normalizedX * 0.15
                            : 0.0) // Tilt left/right
                        ..setTranslationRaw(0.0, _isHovered ? -8.0 : 0.0,
                            _isHovered ? 30.0 : 0.0), // Elevate towards user
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppConstants.surfaceL2,
                          border: Border.all(
                            color: _isHovered
                                ? widget.accentColor.withValues(alpha: 0.5)
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                          boxShadow: [
                            if (_isHovered)
                              BoxShadow(
                                color: widget.accentColor.withValues(alpha: 0.1),
                                blurRadius: 20,
                                spreadRadius: -5,
                                offset: const Offset(0, 8),
                              ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Dynamic Spotlight
                            if (_isHovered)
                              AwardSpotlight(
                                mousePos: mousePos,
                                accentColor: widget.accentColor,
                              ),
                            
                            // Content
                            AwardCardContent(
                              award: widget.award,
                              accentColor: widget.accentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ); // IgnorePointer
                }, // builder for ValueListenableBuilder
              ); // ValueListenableBuilder
            }, // builder for LayoutBuilder
          ), // LayoutBuilder
        ), // GestureDetector
      ), // MouseRegion
    ); // RepaintBoundary
  } // build
} // class

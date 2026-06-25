import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/controller.dart';

/// Premium interactive Menu Button that reactively morphs between a hamburger
/// burger state and a close (X) state with butter-smooth glassmorphic animations.
class MenuButton extends StatefulWidget {
  final VoidCallback? onTap;
  const MenuButton({super.key, this.onTap});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 250),
      builder: (context, value, child) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            child: InkWell(
              onTap: widget.onTap,
              customBorder: const CircleBorder(),
              child: Obx(() {
                final bool isOpen = appController.isMenuOpen.value;
                final Color activeColor = const Color(0xFF8B5CF6);

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  height: 42.0 * value,
                  width: 42.0 * value,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isHovered
                        ? activeColor.withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.03),
                    border: Border.all(
                      color: _isHovered
                          ? activeColor.withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.08),
                      width: 1.0,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: activeColor.withValues(alpha: 0.3),
                              blurRadius: 12,
                              spreadRadius: 1,
                            )
                          ]
                        : [],
                  ),
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)], // Brand colors
                        ).createShader(bounds);
                      },
                      child: Stack(
                        children: [
                          // Top line -> Morphs to close diagonal 1
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            top: isOpen ? 19 : 10,
                            left: 11,
                            width: 18,
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              turns: isOpen ? 0.125 : 0, // 45 degrees
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),
                          // Middle line -> Fades out reactively when open
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            top: 19,
                            left: 11,
                            width: 18,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isOpen ? 0.0 : 1.0,
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),
                          // Bottom line -> Morphs to close diagonal 2
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            bottom: isOpen ? 19 : 10,
                            left: 11,
                            width: 18,
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              turns: isOpen ? -0.125 : 0, // -45 degrees
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

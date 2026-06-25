import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/responsive.dart';

/// Cyber-cyan circular outlined button that routes to the Admin Dashboard.
/// Features a high-fidelity magnetic hover drag, custom scale animation, and playful evasion on desktop.
class AdminDashboardButton extends StatefulWidget {
  const AdminDashboardButton({super.key});

  @override
  State<AdminDashboardButton> createState() => _AdminDashboardButtonState();
}

class _AdminDashboardButtonState extends State<AdminDashboardButton> {
  bool _isAdminHovered = false;
  final ValueNotifier<Offset> _adminMagneticOffset = ValueNotifier(Offset.zero);
  double _evadeOffset = 0.0;

  @override
  void dispose() {
    _adminMagneticOffset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final double containerWidth = isDesktop ? 138 : 38;

    // 38px (button) + 100px (evasion space) = 138px total allocated space.
    // This provides a physical "runway" for the button to move left into without being clipped by the parent Row.
    return SizedBox(
      width: containerWidth,
      height: 38,
      child: MouseRegion(
        onExit: (_) {
          if (isDesktop) {
            setState(() {
              _evadeOffset = 0.0;
            });
          }
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve:
                  Curves.easeInOutBack, // Buttery smooth, bouncy teasing feel
              // When evaded, it moves 100px to the left (meaning right is 100).
              right: _evadeOffset == 0.0 ? 0.0 : 100.0,
              top: 0,
              bottom: 0,
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isAdminHovered = true;
                    // When hovered, toggle the evasion offset
                    if (isDesktop) {
                      _evadeOffset = _evadeOffset == 0.0 ? -100.0 : 0.0;
                    }
                  });
                },
                onExit: (_) => setState(() {
                  _isAdminHovered = false;
                  _adminMagneticOffset.value = Offset.zero;
                }),
                onHover: (event) {
                  final RenderBox? box =
                      context.findRenderObject() as RenderBox?;
                  if (box != null) {
                    final Offset center = box.size.center(Offset.zero);
                    final Offset localPos = event.localPosition;
                      _adminMagneticOffset.value = Offset(
                        (localPos.dx - center.dx) * 0.1,
                        (localPos.dy - center.dy) * 0.1,
                      );
                  }
                },
                cursor: SystemMouseCursors.click,
                child: ValueListenableBuilder<Offset>(
                  valueListenable: _adminMagneticOffset,
                  builder: (context, magneticOffset, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutQuart,
                      transform: Matrix4.translationValues(
                        magneticOffset.dx, // Only micro-magnetic drag here
                        magneticOffset.dy,
                        0,
                      )..multiply(Matrix4.diagonal3Values(
                          _isAdminHovered ? 1.06 : 1.0,
                          _isAdminHovered ? 1.06 : 1.0,
                          1.0,
                        )),
                      child: Tooltip(
                        message: 'Admin Dashboard',
                        child: GestureDetector(
                          onTap: () => Get.toNamed('/admin'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isAdminHovered
                                  ? const Color(0xFF00E5FF).withValues(alpha: 0.08)
                                  : Colors.white.withValues(alpha: 0.02),
                              border: Border.all(
                                color: _isAdminHovered
                                    ? const Color(0xFF00E5FF).withValues(alpha: 0.6)
                                    : const Color(0xFF00E5FF)
                                        .withValues(alpha: 0.2),
                                width: 1.2,
                              ),
                              boxShadow: _isAdminHovered
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF00E5FF)
                                            .withValues(alpha: 0.25),
                                        blurRadius: 10,
                                        spreadRadius: -1,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.admin_panel_settings,
                                color: Color(0xFF00E5FF),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

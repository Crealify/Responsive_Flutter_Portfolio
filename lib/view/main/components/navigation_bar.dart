import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/controller.dart';
import '../../../view_model/responsive.dart';
import 'navigation_button_list.dart';
import 'logo_with_placeholder.dart';
import 'admin_dashboard_button.dart';
import 'hire_me_button.dart';

/// Elite, responsive Top Navigation Bar featuring micro-interactive glassmorphic designs.
/// Implements beautiful, component-driven sub-widgets for logo caching, admin settings, and CTA channels.
class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  bool _isLogoHovered = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool showFullNav = width >= 1100;

    return Obx(() {
      final bool isMenuOpen = appController.isMenuOpen.value;

      return AnimatedBuilder(
        animation: appController.scrollController,
        builder: (context, child) {
          double offset = 0;
          if (appController.scrollController.hasClients) {
            try {
              offset = appController.scrollController.offset;
            } catch (_) {
              if (appController.scrollController.positions.isNotEmpty) {
                offset = appController.scrollController.positions.first.pixels;
              }
            }
          }

          // Pro Glassmorphism transition logic
          final bool isScrolled = offset > 50;
          final double glassOpacity = isScrolled ? 0.25 : 0.12;
          final double blurAmount = isScrolled ? 25.0 : 15.0;
          final double horizontalPadding =
              width < 600 ? 12.0 : (width < 1200 ? 16.0 : 20.0);
          final double topMargin = isScrolled ? 10.0 : 16.0;

          final bool isLarge = Responsive.isExtraLargeScreen(context);

          // Calculate the actual available layout width for the main page stack
          final double layoutWidth =
              isMenuOpen ? (width - (isLarge ? 320.0 : 280.0) - 32.0) : width;

          // Retrieve the exact same padding that the main content is occupying
          final double contentPadding = width < 600
              ? 16.0
              : (width < 1200 ? 32.0 : (isLarge ? 64.0 : 48.0));

          final double maxNavWidth =
              isLarge ? 1440.0 : (isMenuOpen ? 1100.0 : 1200.0);

          // Calculate the target width of the navbar to match the content width exactly
          final double targetWidth = maxNavWidth - 2 * contentPadding;

          return Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              margin: EdgeInsets.only(
                top: topMargin,
                left: layoutWidth < maxNavWidth ? contentPadding : 0,
                right: layoutWidth < maxNavWidth ? contentPadding : 0,
              ),
              height: 60,
              constraints: BoxConstraints(maxWidth: targetWidth),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withValues(alpha: isScrolled ? 0.3 : 0.1),
                    blurRadius: isScrolled ? 25 : 12,
                    offset: Offset(0, isScrolled ? 8 : 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white
                            .withValues(alpha: isScrolled ? 0.12 : 0.05),
                        width: 0.8,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF07111F)
                              .withValues(alpha: glassOpacity),
                          const Color(0xFF030712)
                              .withValues(alpha: glassOpacity * 0.8),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Logo
                        _buildLogo(),

                        if (showFullNav)
                          // Center Navigation Items
                          const Expanded(
                            child: Center(child: NavigationButtonList()),
                          ),

                        if (!showFullNav) const Spacer(),

                        // Right Action Buttons
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const AdminDashboardButton(),
                                SizedBox(
                                  width: Responsive.isDesktop(context) ? 8 : 8,
                                ),
                                HireMeButton(
                                  isCompact: Responsive.isDesktop(context)
                                      ? (width < 450)
                                      : false, // Keep premium full size on mobile/tablet since there is plenty of space in the middle
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildLogo() {
    final double logoHeight = Responsive.isDesktop(context)
        ? 40.0
        : (Responsive.isTablet(context)
            ? 38.0
            : (Responsive.isLargeMobile(context) ? 36.0 : 35.0));

    return MouseRegion(
      onEnter: (_) => setState(() => _isLogoHovered = true),
      onExit: (_) => setState(() => _isLogoHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => appController.scrollToTop(),
        child: AnimatedRotation(
          turns: _isLogoHovered ? 0.05 : 0,
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            height: logoHeight,
            child: LogoWithPlaceholder(
              isHovered: _isLogoHovered,
              height: logoHeight,
            ),
          ),
        ),
      ),
    );
  }
}

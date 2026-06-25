import 'package:anilbhattarai_portfolio/view/main/components/drawer/contact_icons.dart';
import 'package:anilbhattarai_portfolio/view/main/components/drawer/personal_info.dart';
import 'package:anilbhattarai_portfolio/view_model/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/constants.dart';
import '../../../../view_model/responsive.dart';
import 'knowledges.dart';
import 'about.dart';
import 'my_skill.dart';
import 'sticky_scroll_header.dart';

/// A custom side drawer featuring dynamic sticky scroll headers and modular children.
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ScrollController _scrollController;
  bool _hideAvailability = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      if (offset > 20) {
        if (!_hideAvailability) {
          setState(() {
            _hideAvailability = true;
          });
        }
      } else {
        if (_hideAvailability) {
          setState(() {
            _hideAvailability = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Container(
      decoration: BoxDecoration(
        color: AppConstants.bgColor,
        border: isDesktop
            ? Border(
                right: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1), width: 1))
            : null,
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: isDesktop ? (Responsive.isExtraLargeScreen(context) ? 320 : 280) : MediaQuery.sizeOf(context).width,
        child: SafeArea(
          child: Stack(
            children: [
              Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: (appController.isMenuOpen.value || !isDesktop) ? 1.0 : 0.0,
                child: RepaintBoundary(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            color: Colors.transparent, 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                About(hideAvailability: _hideAvailability),
                                // Subtle shadow/divider for header depth
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        AppConstants.activeIconColor.withValues(alpha: 0.2),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isDesktop ? AppConstants.spacing24 : AppConstants.spacing32,
                                    vertical: AppConstants.spacing16,
                                  ),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      PersonalInfo(),
                                      SizedBox(height: AppConstants.spacing16),
                                      MySKills(),
                                      SizedBox(height: AppConstants.spacing16),
                                      Knowledges(),
                                      Divider(color: Colors.white12, height: 60),
                                      ContactIcon(),
                                      SizedBox(height: 40), // Bottom breathing room
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              // Advanced Sticky Scroll Header Overlay
              AnimatedBuilder(
                animation: _scrollController,
                builder: (context, child) {
                  double offset = 0.0;
                  if (_scrollController.hasClients) {
                    offset = _scrollController.offset;
                  }
                  return StickyScrollHeader(scrollOffset: offset);
                },
              ),
              // Premium Floating Close Button with gradient fade
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Obx(() => AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: (appController.isMenuOpen.value || !isDesktop) ? 1.0 : 0.0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      child: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white12),
                          ),
                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                        onPressed: () {
                          if (isDesktop) {
                            appController.toggleMenu();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

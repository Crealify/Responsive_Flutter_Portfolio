import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/controller.dart';
import 'navigation_button.dart';

/// Interactive list of navigation links with active state tracking.
class NavigationButtonList extends StatelessWidget {
  const NavigationButtonList({super.key});

  static final List<GlobalKey> _desktopNavbarKeys = [
    AppController.homeKey,
    AppController.experienceKey,
    AppController.projectsKey,
    AppController.techStackKey,
    AppController.educationKey,
  ];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Obx(() => FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavItem(
                  label: 'Home',
                  sectionKey: AppController.homeKey,
                  isDefault: true,
                ),
                const SizedBox(width: 8),
                _buildNavItem(
                  label: 'Experience',
                  sectionKey: AppController.experienceKey,
                ),
                const SizedBox(width: 8),
                _buildNavItem(
                  label: 'Projects',
                  sectionKey: AppController.projectsKey,
                ),
                const SizedBox(width: 8),
                _buildNavItem(
                  label: 'Tech',
                  sectionKey: AppController.techStackKey,
                ),
                const SizedBox(width: 8),
                _buildNavItem(
                  label: 'Education',
                  sectionKey: AppController.educationKey,
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  Widget _buildNavItem({
    required String label,
    required GlobalKey sectionKey,
    bool isDefault = false,
  }) {
    final GlobalKey? activeKey = appController.activeSectionKey.value;
    
    // Is active if the traced active section matches our key, OR
    // if this is the default (Home) item and the traced section is NOT present in any desktop button's key.
    final bool isActive = activeKey == sectionKey || 
        (isDefault && !_desktopNavbarKeys.contains(activeKey));

    return NavigationTextButton(
      onTap: () {
        appController.scrollToSection(sectionKey);
        appController.activeSectionKey.value = sectionKey;
      },
      isActive: isActive,
      text: label,
    );
  }
}

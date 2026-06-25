import 'package:flutter/material.dart';
import '../../../../res/components/scroll_reveal.dart';
import '../../../../res/constants.dart';
import 'education_nodes.dart';

class MobileEducationTimeline extends StatelessWidget {
  final List<dynamic> educations;
  final ValueNotifier<int> hoveredIndexNotifier;

  const MobileEducationTimeline({
    super.key,
    required this.educations,
    required this.hoveredIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: educations.length,
      itemBuilder: (context, index) {
        final edu = educations[index];
        final String yearText = edu.duration.toString().replaceAll('🎓', '').trim();

        return ScrollReveal(
          baseKey: 'edu_mobile',
          index: index,
          delay: Duration(milliseconds: index * 120),
          child: ValueListenableBuilder<int>(
            valueListenable: hoveredIndexNotifier,
            builder: (context, hoveredIndex, _) {
              final bool isHovered = hoveredIndex == index;
              final Color activeColor = index == 0 ? const Color(0xFF00FFD2) : const Color(0xFFFF00A0);
              final Color nodeColor = isHovered ? activeColor : AppConstants.primaryColor;

              return MobileEducationNode(
                activeColor: activeColor,
                nodeColor: nodeColor,
                isHovered: isHovered,
                index: index,
                yearText: yearText,
                totalCount: educations.length,
                onHover: (hovering) {
                  hoveredIndexNotifier.value = hovering ? index : -1;
                },
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/components/scroll_reveal.dart';
import '../../../../res/constants.dart';
import 'education_details.dart';
import 'education_nodes.dart';

class DesktopEducationTree extends StatelessWidget {
  final List<dynamic> educations;
  final ValueNotifier<int> hoveredIndexNotifier;

  const DesktopEducationTree({
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
        final bool isLeft = index % 2 == 0;
        
        return ScrollReveal(
          baseKey: 'edu_desktop',
          index: index,
          delay: Duration(milliseconds: index * 120),
          child: ValueListenableBuilder<int>(
            valueListenable: hoveredIndexNotifier,
            builder: (context, hoveredIndex, _) {
              final bool isHovered = hoveredIndex == index;
              
              // Premium alternating color themes
              final Color activeColor = index == 0 ? const Color(0xFF00FFD2) : const Color(0xFFFF00A0);
              final Color nodeColor = isHovered ? activeColor : AppConstants.primaryColor.withValues(alpha: 0.7);

              // Clean up the duration string (remove emoji if present, as we use the vector icon)
              final String yearText = edu.duration.toString().replaceAll('🎓', '').trim();

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Branch Section
                  Expanded(
                    child: isLeft
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Card with hover callback
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: EducationCard(
                                    index: index,
                                    onHover: (hovering) {
                                      hoveredIndexNotifier.value = hovering ? index : -1;
                                    },
                                  ).animate()
                                   .fadeIn(duration: 800.ms)
                                   .slideX(begin: -0.15, curve: Curves.easeOutBack),
                                ),
                              ),
                              // Glow connecting horizontal branch trunk
                              EducationHorizontalConnector(
                                activeColor: activeColor,
                                isHovered: isHovered,
                                rightToLeft: true,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),

                  // Center Holographic Node Axis
                  Column(
                    children: [
                      // Top Connector line
                      EducationSpineSegment(
                        activeColor: activeColor,
                        isHovered: isHovered,
                        isFirst: index == 0,
                        isLast: false,
                        topToBottom: true,
                      ),

                      // Year Indicator Pill
                      EducationYearPill(
                        year: yearText,
                        activeColor: activeColor,
                        isHovered: isHovered,
                      ),

                      const SizedBox(height: 8),

                      // Holographic central node
                      EducationHolographicNode(
                        nodeColor: nodeColor,
                        isHovered: isHovered,
                      ),

                      // Bottom Connector line
                      EducationSpineSegment(
                        activeColor: activeColor,
                        isHovered: isHovered,
                        isFirst: false,
                        isLast: index == educations.length - 1,
                        topToBottom: false,
                      ),
                    ],
                  ),

                  // Right Branch Section
                  Expanded(
                    child: !isLeft
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Glow connecting horizontal branch trunk
                              EducationHorizontalConnector(
                                activeColor: activeColor,
                                isHovered: isHovered,
                                rightToLeft: false,
                              ),
                              // Card with hover callback
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: EducationCard(
                                    index: index,
                                    onHover: (hovering) {
                                      hoveredIndexNotifier.value = hovering ? index : -1;
                                    },
                                  ).animate()
                                   .fadeIn(duration: 800.ms)
                                   .slideX(begin: 0.15, curve: Curves.easeOutBack),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

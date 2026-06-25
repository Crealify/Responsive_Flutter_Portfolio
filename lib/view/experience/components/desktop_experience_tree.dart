import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/components/scroll_reveal.dart';
import 'experience_details.dart';
import 'experience_nodes.dart';

class DesktopExperienceTree extends StatelessWidget {
  final List<dynamic> exps;
  final ValueNotifier<int> hoveredIndex;
  final Color Function(int) accentFor;

  const DesktopExperienceTree({
    super.key,
    required this.exps,
    required this.hoveredIndex,
    required this.accentFor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: exps.length,
      itemBuilder: (context, index) {
        final bool isLeft = index % 2 == 0;
        final Color accent = accentFor(index);

        // Parse company/location split
        final parts = exps[index].company.toString().split('\n');
        final companyName = parts.isNotEmpty ? parts[0].trim() : '';

        // Parse duration range
        final dParts = exps[index].duration.toString().split('\n');
        final yearText = dParts.length == 2
            ? '${dParts[0].trim()} – ${dParts[1].trim()}'
            : exps[index].duration.toString();

        return ScrollReveal(
          baseKey: 'exp_desktop',
          index: index,
          delay: Duration(milliseconds: index * 120),
          child: ValueListenableBuilder<int>(
            valueListenable: hoveredIndex,
            builder: (context, hoveredIdx, _) {
              final bool isHovered = hoveredIdx == index;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── LEFT SIDE ────────────────────────────────────────────
                  Expanded(
                    child: isLeft
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 24),
                                  child: ExperienceStack(
                                    index: index,
                                    onHover: (h) =>
                                        hoveredIndex.value = h ? index : -1,
                                  )
                                      .animate()
                                      .fadeIn(duration: 700.ms)
                                      .slideX(
                                          begin: -0.12,
                                          curve: Curves.easeOutBack),
                                ),
                              ),
                              // Neon branch connector → center
                              ExperienceHorizontalConnector(accent: accent, isHovered: isHovered, rightToLeft: true),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),

                  // ── CENTER SPINE NODE ─────────────────────────────────────
                  Column(
                    children: [
                      // Top spine segment
                      ExperienceSpineSegment(
                        accent: accent,
                        isHovered: isHovered,
                        isFirst: index == 0,
                        isLast: false,
                        topToBottom: true,
                      ),

                      // Year pill
                      ExperienceYearPill(year: yearText, accent: accent, isHovered: isHovered),

                      const SizedBox(height: 6),

                      // Holographic node
                      ExperienceHolographicNode(accent: accent, isHovered: isHovered, index: index, label: companyName),

                      // Bottom spine segment
                      ExperienceSpineSegment(
                        accent: accent,
                        isHovered: isHovered,
                        isFirst: false,
                        isLast: index == exps.length - 1,
                        topToBottom: false,
                      ),
                    ],
                  ),

                  // ── RIGHT SIDE ───────────────────────────────────────────
                  Expanded(
                    child: !isLeft
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Neon branch connector ← center
                              ExperienceHorizontalConnector(accent: accent, isHovered: isHovered, rightToLeft: false),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: ExperienceStack(
                                    index: index,
                                    onHover: (h) =>
                                        hoveredIndex.value = h ? index : -1,
                                  )
                                      .animate()
                                      .fadeIn(duration: 700.ms)
                                      .slideX(
                                          begin: 0.12,
                                          curve: Curves.easeOutBack),
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

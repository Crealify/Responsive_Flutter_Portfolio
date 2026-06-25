import 'package:flutter/material.dart';
import '../../../../res/components/scroll_reveal.dart';
import 'experience_nodes.dart';

class MobileExperienceTimeline extends StatelessWidget {
  final List<dynamic> exps;
  final ValueNotifier<int> hoveredIndex;
  final Color Function(int) accentFor;

  const MobileExperienceTimeline({
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
        final Color accent = accentFor(index);

        final dParts = exps[index].duration.toString().split('\n');
        final yearText = dParts.length == 2
            ? '${dParts[0].trim()} – ${dParts[1].trim()}'
            : exps[index].duration.toString();

        return ScrollReveal(
          baseKey: 'exp_mobile',
          index: index,
          delay: Duration(milliseconds: index * 120),
          child: ValueListenableBuilder<int>(
            valueListenable: hoveredIndex,
            builder: (context, hoveredIdx, _) {
              final bool isHovered = hoveredIdx == index;

              return MobileExperienceNode(
                accent: accent,
                isHovered: isHovered,
                index: index,
                yearText: yearText,
                totalCount: exps.length,
                onHover: (h) => hoveredIndex.value = h ? index : -1,
              );
            },
          ),
        );
      },
    );
  }
}

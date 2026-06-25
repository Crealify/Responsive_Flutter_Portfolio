import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectTerminalHeader extends StatelessWidget {
  final dynamic proj;
  final bool isHovered;
  final Color accent;

  const ProjectTerminalHeader({
    super.key,
    required this.proj,
    required this.isHovered,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    String cleanName = proj.name
        .toString()
        .split('-')[0]
        .split('(')[0]
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_');
    if (cleanName.length > 14) {
      cleanName = cleanName.substring(0, 14);
    }
    final String tabFileName = '$cleanName.dart';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFF5F56))),
            const SizedBox(width: 6),
            Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFBD2E))),
            const SizedBox(width: 6),
            Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF27C93F))),
          ],
        ),
        Flexible(
          child: AnimatedContainer(
            duration: 300.ms,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: isHovered ? accent.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isHovered ? accent.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.06),
                width: 1,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    proj.link.contains('github.com') ? Icons.code_rounded : Icons.apple,
                    size: 13,
                    color: isHovered ? accent : Colors.white.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    tabFileName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: isHovered ? Colors.white : Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Icon(
          Icons.cloud_done_outlined,
          size: 14,
          color: isHovered ? accent.withValues(alpha: 0.8) : Colors.white24,
        ),
      ],
    );
  }
}

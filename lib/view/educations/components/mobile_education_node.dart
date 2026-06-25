import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../res/constants.dart';
import 'education_details.dart';

class MobileEducationNode extends StatelessWidget {
  final Color activeColor;
  final Color nodeColor;
  final bool isHovered;
  final int index;
  final String yearText;
  final int totalCount;
  final ValueChanged<bool> onHover;

  const MobileEducationNode({
    super.key,
    required this.activeColor,
    required this.nodeColor,
    required this.isHovered,
    required this.index,
    required this.yearText,
    required this.totalCount,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 22.75,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isHovered ? activeColor : AppConstants.primaryColor.withValues(alpha: 0.4),
                  index == totalCount - 1 ? Colors.transparent : AppConstants.primaryColor.withValues(alpha: 0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [nodeColor.withValues(alpha: isHovered ? 0.3 : 0.1), Colors.transparent],
                        ),
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                     .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: const Duration(milliseconds: 1500)),

                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [nodeColor, nodeColor.withValues(alpha: 0.6)]),
                        boxShadow: [BoxShadow(color: nodeColor.withValues(alpha: 0.3), blurRadius: 10)],
                      ),
                      child: const Center(child: Icon(Icons.school_rounded, color: Colors.white, size: 16)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: AppConstants.spacing16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.spacing32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            activeColor.withValues(alpha: isHovered ? 0.18 : 0.08),
                            const Color(0xFF07111F).withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isHovered ? activeColor : activeColor.withValues(alpha: 0.3), width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: isHovered ? activeColor.withValues(alpha: 0.25) : activeColor.withValues(alpha: 0.05),
                            blurRadius: isHovered ? 10 : 4,
                          ),
                        ],
                      ),
                      child: Text(yearText,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                    ),
                    const SizedBox(height: 8),
                    EducationCard(index: index, onHover: onHover)
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOutExpo),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

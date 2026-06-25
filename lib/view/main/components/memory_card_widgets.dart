import 'package:flutter/material.dart';
import '../../../res/constants.dart';

/// Shared shimmer bottom line widget used inside MemoryCard
class MemoryShimmerLine extends AnimatedWidget {
  const MemoryShimmerLine({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final anim = listenable as Animation<double>;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0 + 2.0 * anim.value, 0),
          end: Alignment(1.0 + 2.0 * anim.value, 0),
          colors: [
            AppConstants.primaryColor.withValues(alpha: 0.3),
            AppConstants.primaryColor,
            AppConstants.secondaryColor,
            AppConstants.activeIconColor,
            AppConstants.secondaryColor,
            AppConstants.primaryColor.withValues(alpha: 0.3),
          ],
          stops: const [0.0, 0.15, 0.35, 0.65, 0.85, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.activeIconColor.withValues(alpha: 0.25),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
    );
  }
}

/// Bottom info panel of a MemoryCard shown on hover
class MemoryCardFooter extends StatelessWidget {
  final String title;
  final bool isVertical;
  final bool isHovered;

  const MemoryCardFooter({
    super.key,
    required this.title,
    required this.isVertical,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spacing16,
        vertical: isHovered ? AppConstants.spacing16 : AppConstants.spacing12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A).withValues(alpha: 0.85),
        border: Border(
          top: BorderSide(
            color: isHovered
                ? AppConstants.primaryColor.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isHovered ? 13.5 : 12.5,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: isHovered ? 16 : 0,
                height: 16,
                child: Opacity(
                  opacity: isHovered ? 1.0 : 0.0,
                  child: const Icon(Icons.arrow_forward_rounded, color: AppConstants.primaryColor, size: 14),
                ),
              ),
            ],
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "COLLEGE MEMORY",
                    style: TextStyle(
                      color: AppConstants.activeIconColor.withValues(alpha: 0.9),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    isVertical ? "VERTICAL" : "HORIZONTAL",
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 8.5, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            crossFadeState: isHovered ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

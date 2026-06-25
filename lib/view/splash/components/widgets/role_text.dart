import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class RoleText extends StatelessWidget {
  final double progress;
  const RoleText({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final show = progress > 0.6;
    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedSlide(
        offset: show ? Offset.zero : const Offset(0, 0.3),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'COMPUTER ENGINEER',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 4,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.7),
                fontFamily: 'Outfit',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: 1.5,
                height: 12,
                decoration: BoxDecoration(
                  color: AppConstants.activeIconColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.activeIconColor.withValues(alpha: 0.8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'FULL STACK ENGINEER',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 4,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.7),
                fontFamily: 'Outfit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

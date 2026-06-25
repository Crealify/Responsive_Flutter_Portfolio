import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class TypingBadges extends StatelessWidget {
  final int row;
  final int col;
  final bool completed;

  const TypingBadges({
    super.key,
    required this.row,
    required this.col,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<PortfolioController>();
      final hasLeaderboard = controller.leaderboard.isNotEmpty;
      final bool showTop = hasLeaderboard && (row > 0 || col >= 5) && !completed;

      if (showTop) {
        final top = controller.leaderboard[0];
        final rawName = top['name'].toString().split(' ')[0];
        final displayName = rawName.length > 7 ? '${rawName.substring(0, 6)}…' : rawName;

        return Positioned(
          top: 12,
          right: 18,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF07111F).withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.amber.withValues(alpha: 0.40),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.08),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 12,
                  height: 12,
                  child: Center(
                    child: Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "Top: $displayName (${top['score']})",
                  style: GoogleFonts.firaCode(
                    color: Colors.amber,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),
        );
      }

      return Positioned(
        top: 12,
        right: 18,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF07111F).withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.35),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.08),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 12,
                height: 12,
                child: Center(
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF10B981),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "Live Typing",
                style: GoogleFonts.firaCode(
                  color: const Color(0xFF10B981),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

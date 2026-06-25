import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

/// Renders the availability tags (Available/Working/On Leave) inside the sticky header.
class StickyAvailabilityRow extends StatelessWidget {
  const StickyAvailabilityRow({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController pc = Get.find<PortfolioController>();

    return Obx(() {
      final contact = pc.contactConfig.value;
      final text = contact.availability.toLowerCase();
      bool isWorking = text.contains('working') || text.contains('busy') || text.contains('project');
      bool isLeave = text.contains('leave') || text.contains('unavailable') || text.contains('off');
      bool isAvailable = contact.availability.isNotEmpty && !isWorking && !isLeave;

      Widget buildStickyChip(String label, IconData icon, Color color, bool isActive) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? color.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isActive ? color.withValues(alpha: 0.35) : Colors.transparent,
              width: 1,
            ),
            boxShadow: isActive ? [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ] : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 11, color: isActive ? color : Colors.white.withValues(alpha: 0.35)),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? color : Colors.white.withValues(alpha: 0.45),
                  fontSize: 9,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        );
      }

      return Align(
        key: const ValueKey('sticky_chips'),
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildStickyChip("Available", Icons.bolt_rounded, Colors.greenAccent, isAvailable),
                const SizedBox(width: 4),
                buildStickyChip("Working", Icons.computer_rounded, Colors.orangeAccent, isWorking),
                const SizedBox(width: 4),
                buildStickyChip("On Leave", Icons.flight_takeoff_rounded, Colors.redAccent, isLeave),
              ],
            ),
          ),
        ),
      );
    });
  }
}

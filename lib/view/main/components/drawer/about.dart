import 'package:anilbhattarai_portfolio/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'drawer_image.dart';

/// Top section of the drawer featuring the profile image and title.
class About extends StatelessWidget {
  final bool hideAvailability;
  const About({super.key, this.hideAvailability = false});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppConstants.bgColor,
      ),
      child: Obx(() {
        final hero = controller.heroConfig.value;
        final contact = controller.contactConfig.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 28),
            const DrawerImage(),
            const SizedBox(height: 10),
            Text(
              hero.name.replaceAll('.', ''),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              contact.availability,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            // Location and Availability Info Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Builder(
                builder: (context) {
                  final text = contact.availability.toLowerCase();
                  
                  bool isWorking = text.contains('working') || text.contains('busy') || text.contains('project');
                  bool isLeave = text.contains('leave') || text.contains('unavailable') || text.contains('off');
                  bool isAvailable = contact.availability.isNotEmpty && !isWorking && !isLeave;

                  Widget buildChip(String label, IconData icon, Color color, bool isActive) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isActive ? color.withValues(alpha: 0.3) : Colors.transparent,
                          width: 1,
                        ),
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

                  return Column(
                    children: [
                      if (contact.location.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on_rounded, size: 11, color: Colors.cyanAccent),
                              const SizedBox(width: 5),
                              Text(
                                contact.location,
                                style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: (!hideAvailability && contact.availability.isNotEmpty)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          buildChip("Available", Icons.bolt_rounded, Colors.greenAccent, isAvailable),
                                          const SizedBox(width: 4),
                                          buildChip("Working", Icons.computer_rounded, Colors.orangeAccent, isWorking),
                                          const SizedBox(width: 4),
                                          buildChip("On Leave", Icons.flight_takeoff_rounded, Colors.redAccent, isLeave),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  );
                }
              ),
            ),
          ],
        );
      }),
    );
  }
}

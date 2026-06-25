import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

/// Renders the profile picture, name, and role tag within the custom drawer sticky header.
class StickyProfileRow extends StatelessWidget {
  const StickyProfileRow({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController pc = Get.find<PortfolioController>();

    return Obx(() {
      final photoUrl = pc.heroConfig.value.photoUrl;
      final name = pc.heroConfig.value.name.replaceAll('.', '');
      final contact = pc.contactConfig.value;

      return Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.55),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.15),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: photoUrl.isNotEmpty && photoUrl.startsWith('http')
                  ? Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 16, color: Colors.white54),
                    )
                  : Image.asset(
                      photoUrl.isNotEmpty ? photoUrl : 'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 16, color: Colors.white54),
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  shadows: [
                    Shadow(
                      color: Colors.cyanAccent,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  Text(
                    contact.availability.isNotEmpty ? contact.availability : 'Junior Flutter Developer',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 8.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}

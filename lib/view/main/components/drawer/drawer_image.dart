import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/constants.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class DrawerImage extends StatefulWidget {
  const DrawerImage({super.key});

  @override
  State<DrawerImage> createState() => _DrawerImageState();
}

class _DrawerImageState extends State<DrawerImage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PortfolioController pc = Get.find<PortfolioController>();

    return Obx(() => Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFFF4D8D), Color(0xFF6C7BFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF4D8D).withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: const Color(0xFF6C7BFF).withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: AppConstants.bgColor,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: pc.heroConfig.value.photoUrl.isNotEmpty && pc.heroConfig.value.photoUrl.startsWith('http')
                  ? Image.network(
                      pc.heroConfig.value.photoUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator(color: Colors.white24));
                      },
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 40, color: Colors.white54),
                    )
                  : Image.asset(
                      pc.heroConfig.value.photoUrl.isNotEmpty ? pc.heroConfig.value.photoUrl : 'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 40, color: Colors.white54),
                    ),
            ),
          ),
        ),
        // Messenger Style Active Status
        Positioned(
          right: 6,
          bottom: 6,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color.lerp(
                    const Color(0xFF00C853), // Deep green
                    const Color(0xFF69F0AE), // Bright green
                    _pulseController.value,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppConstants.bgColor, width: 4),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}

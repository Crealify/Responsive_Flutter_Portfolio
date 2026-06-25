import 'package:anilbhattarai_portfolio/res/components/responsive_grid.dart';
import 'package:anilbhattarai_portfolio/res/components/section_header.dart';
import 'package:anilbhattarai_portfolio/view/certifications/components/certificates_details.dart';
import 'package:anilbhattarai_portfolio/view_model/getx_controllers/portfolio_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/skeleton_card.dart';
import '../../res/constants.dart';
import '../../view_model/responsive.dart';
import '../../res/components/pagination_strips.dart';

/// A gallery section highlighting professional licenses and certifications.
class Certifications extends StatefulWidget {
  const Certifications({super.key});

  @override
  State<Certifications> createState() => _CertificationsState();
}

class _CertificationsState extends State<Certifications>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  int? _visibleCount;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find<PortfolioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'License & ', title: 'Certifications'),
        const SizedBox(height: AppConstants.spacing40),
        
        Obx(() {
          // --- Loading State ---
          if (controller.isCertificationsLoading.value && controller.certifications.isEmpty) {
            return Responsive(
              desktop: _buildSkeletonGrid(4, 1.6),
              extraLargeScreen: _buildSkeletonGrid(4, 1.6),
              tablet: _buildSkeletonGrid(2, 1.7),
              largeMobile: _buildSkeletonGrid(1, 1.8),
              mobile: _buildSkeletonGrid(1, 1.4),
            );
          }

          final certificateData = controller.certifications;
          final bool isDesktop = Responsive.isDesktop(context);
          final int initialLimit = isDesktop ? 4 : 3;
          _visibleCount ??= initialLimit;
          final int hiddenCount = (certificateData.length - _visibleCount!).clamp(0, 999);
          final int limit = (certificateData.length > _visibleCount!) ? _visibleCount! : certificateData.length;

          return Column(
            children: [
              Responsive(
                desktop: _buildGrid(4, 1.3, limit),
                extraLargeScreen: _buildGrid(4, 1.3, limit),
                tablet: _buildGrid(2, 1.2, limit),
                largeMobile: _buildGrid(1, 1.6, limit),
                mobile: _buildGrid(1, 1.2, limit),
              ),

              // --- Premium Shimmering Reveal Strip ---
              if (certificateData.length > initialLimit) ...[
                const SizedBox(height: AppConstants.spacing24),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: _visibleCount! >= certificateData.length
                      ? CollapseStrip(onTap: () => setState(() => _visibleCount = initialLimit))
                      : RevealStrip(
                          hiddenCount: hiddenCount,
                          shimmerController: _shimmerController,
                          onTap: () => setState(() => _visibleCount = _visibleCount! + initialLimit),
                          itemName: 'certification',
                        ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }

  /// Internal helper to build the certification grid.
  Widget _buildGrid(int count, double ratio, int itemCount) {
    return ResponsiveGrid(
      itemCount: itemCount,
      crossAxisCount: count,
      ratio: ratio,
      itemBuilder: (context, index) => CertificateStack(index: index)
          .animate(delay: (index * 100).ms)
          .fadeIn(duration: 800.ms)
          .slideX(begin: 0.2, end: 0, curve: Curves.easeOutExpo)
          .scale(begin: const Offset(0.9, 0.9)),
    );
  }

  /// Internal helper to build a skeleton loading grid.
  Widget _buildSkeletonGrid(int count, double ratio) {
    return ResponsiveGrid(
      itemCount: count,
      crossAxisCount: count,
      ratio: ratio,
      itemBuilder: (context, index) => const SkeletonCard(),
    );
  }
}



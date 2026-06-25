import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import '../../../res/constants.dart';
import '../../../res/components/section_header.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import 'package:get/get.dart';
import 'featured_video_card.dart';

/// A YouTube showcase section with auto-playing video previews on hover.
class FeaturedVideos extends StatelessWidget {
  const FeaturedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(prefix: 'YouTube ', title: 'Vibes'),
        SizedBox(height: AppConstants.spacing40),
        _VideoGrid(),
      ],
    );
  }
}

class _VideoGrid extends StatelessWidget {
  const _VideoGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double availableWidth = constraints.maxWidth;
      final bool isMobile = availableWidth < 700; // Threshold for mobile stacking
      final int crossAxisCount = isMobile ? 1 : 3;
      
      return Obx(() {
        final controller = Get.find<PortfolioController>();
        final allVideos = controller.videos;
        
        if (allVideos.isEmpty) return const SizedBox.shrink();

        // Always limit to top 3 videos
        final displayedVideos = allVideos.take(3).toList();
        
        return Column(
          children: [
            Wrap(
              spacing: AppConstants.spacing16,
              runSpacing: AppConstants.spacing16,
              children: displayedVideos.asMap().entries.map((entry) {
                final index = entry.key;
                final video = entry.value;
                const double gap = AppConstants.spacing16;
                
                // Calculate width based on columns
                final double horizontalPadding = 0;
                final double totalGap = (crossAxisCount - 1) * gap;
                final double cardWidth = (availableWidth - horizontalPadding - totalGap) / crossAxisCount;
                
                return FeaturedVideoCard(
                  key: ValueKey(video.videoId),
                  videoId: video.videoId,
                  title: video.title,
                  width: cardWidth,
                  index: index,
                ).animate(delay: (index * 150).ms).fadeIn().slideY(begin: 0.1);
              }).toList(),
            ),
          ],
        );
      });
    });
  }
}


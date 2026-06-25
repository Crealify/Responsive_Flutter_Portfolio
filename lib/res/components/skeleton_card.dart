import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants.dart';

class SkeletonCard extends StatelessWidget {
  final double? height;
  final double? width;
  const SkeletonCard({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(AppConstants.spacing16),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / Title placeholder
          _buildPlaceholder(height: 20, width: 150),
          const SizedBox(height: AppConstants.spacing16),
          // Description / Subtitle placeholders
          _buildPlaceholder(height: 12, width: double.infinity),
          const SizedBox(height: AppConstants.spacing8),
          _buildPlaceholder(height: 12, width: 200),
          if (height != null) const Spacer() else const SizedBox(height: 32),
          // Footer placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPlaceholder(height: 24, width: 80, radius: 12),
              _buildPlaceholder(height: 20, width: 20, isCircle: true),
            ],
          ),
        ],
      ).animate(onPlay: (c) => c.repeat())
       .shimmer(duration: 1500.ms, color: Colors.white.withValues(alpha: 0.05)),
    );
  }

  Widget _buildPlaceholder({
    required double height,
    required double width,
    double radius = 6,
    bool isCircle = false,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: isCircle ? null : BorderRadius.circular(radius),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}

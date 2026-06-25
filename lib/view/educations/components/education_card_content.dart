import 'package:flutter/material.dart';
import '../../../../model/education_model.dart';
import '../../../res/constants.dart';

class EducationCardContent extends StatelessWidget {
  final Education edu;
  final bool isHovered;
  final Color cyberColor;

  const EducationCardContent({
    super.key,
    required this.edu,
    required this.isHovered,
    required this.cyberColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left-side glowing vertical cyber strip (Active on hover!)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 80,
            width: 3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [
                  isHovered ? cyberColor : Colors.white10,
                  isHovered
                      ? cyberColor.withValues(alpha: 0.2)
                      : Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: cyberColor.withValues(alpha: 0.8),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Title, text and detail bodies
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  edu.degree,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                        fontSize: 16.5,
                        letterSpacing: 0.3,
                      ),
                ),
                const SizedBox(height: 8),

                // Frosted Capsule Badge for University/School Name
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Text(
                    edu.institution,
                    style: TextStyle(
                        color: isHovered
                            ? cyberColor
                            : AppConstants.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2),
                  ),
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppConstants.locationTextColor,
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        edu.location,
                        style: const TextStyle(
                            color: AppConstants.locationTextColor,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                if (edu.description.trim().isNotEmpty &&
                    !edu.description
                        .trim()
                        .startsWith('http')) ...[
                  const SizedBox(height: AppConstants.spacing16),
                  Text(
                    edu.description,
                    style: const TextStyle(
                        color: AppConstants.bodyTextColor,
                        fontSize: 13,
                        height: 1.45,
                        letterSpacing: 0.1),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

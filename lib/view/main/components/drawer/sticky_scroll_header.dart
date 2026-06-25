import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../res/constants.dart';
import 'sticky_profile_row.dart';
import 'sticky_availability_row.dart';
import 'sticky_section_title.dart';

/// Premium glassmorphic Sticky Header for the custom drawer.
/// Implements beautiful, component-driven sub-widgets for profile cards, availability chips, and dynamic titles.
class StickyScrollHeader extends StatelessWidget {
  final double scrollOffset;
  const StickyScrollHeader({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    if (scrollOffset < 40) {
      return const SizedBox.shrink();
    }

    // Interpolations for ultra-smooth dynamic transition
    double bgProgress = ((scrollOffset - 40) / 40.0).clamp(0.0, 1.0);
    double blurSigma = bgProgress * 10.0;
    double opacity = bgProgress;
    
    // Content fades in slightly later
    double contentOpacity = ((scrollOffset - 65) / 20.0).clamp(0.0, 1.0);

    // Height is fixed at 138px during all active phases to ensure instant, stable sticky layout and zero overflow
    const double height = 138.0;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 64, top: 8, bottom: 8), // Safe room for close button
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppConstants.bgColor.withValues(alpha: 0.92 * opacity),
                AppConstants.bgColor.withValues(alpha: 0.85 * opacity),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35 * opacity),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: Colors.cyanAccent.withValues(alpha: 0.12 * opacity),
                width: 1,
              ),
            ),
          ),
          child: Opacity(
            opacity: contentOpacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Pinned Profile Row (Always stays in place)
                const StickyProfileRow(),
                const SizedBox(height: 6),
                
                // Divider 1: Ultra-thin cyan gradient visual divider
                Container(
                  height: 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyanAccent.withValues(alpha: 0.0),
                        Colors.cyanAccent.withValues(alpha: 0.15),
                        Colors.cyanAccent.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                
                // Row 2: Pinned Availability Row (Stays permanently locked at the top)
                const StickyAvailabilityRow(),
                const SizedBox(height: 6),
                
                // Divider 2: Ultra-thin cyan gradient visual divider
                Container(
                  height: 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyanAccent.withValues(alpha: 0.0),
                        Colors.cyanAccent.withValues(alpha: 0.15),
                        Colors.cyanAccent.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                
                // Row 3: Dynamic Swapping Section Title (Always active, swaps instantly!)
                StickySectionTitle(scrollOffset: scrollOffset),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../res/constants.dart';
import 'experience_contributions.dart';

class ExperienceCardContent extends StatelessWidget {
  final bool isHovered;
  final dynamic exp;
  final Color accent;
  final String companyName;
  final String location;

  const ExperienceCardContent({
    super.key,
    required this.isHovered,
    required this.exp,
    required this.accent,
    required this.companyName,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header Row ───────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left accent bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 3.5,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  colors: [
                    isHovered ? accent : Colors.white12,
                    isHovered ? accent.withValues(alpha: 0.2) : Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  if (isHovered)
                    BoxShadow(
                      color: accent.withValues(alpha: 0.7),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Title + Company block
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                      fontSize: 15.5,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  // Frosted company capsule
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: isHovered ? 0.12 : 0.06),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: accent.withValues(alpha: isHovered ? 0.3 : 0.12),
                      ),
                    ),
                    child: Text(
                      companyName,
                      style: TextStyle(
                        color: isHovered ? accent : accent.withValues(alpha: 0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // ── Location Row ─────────────────────────────
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: AppConstants.locationTextColor, size: 13),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                location.isNotEmpty ? location : '—',
                style: TextStyle(color: AppConstants.locationTextColor, fontSize: 12, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // ── Divider ───────────────────────────────────
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent.withValues(alpha: isHovered ? 0.4 : 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ── Key Contributions ─────────────────────────
        ExperienceContributions(
          responsibilities: exp.responsibilities,
          accent: accent,
        ),
      ],
    );
  }
}

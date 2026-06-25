import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../res/constants.dart';
import '../../../../model/certificate_model.dart';

class CertificateContent extends StatelessWidget {
  final CertificateModel cert;
  final bool isHovered;
  final Color accent;
  final List<String> skillList;

  const CertificateContent({
    super.key,
    required this.cert,
    required this.isHovered,
    required this.accent,
    required this.skillList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Top Header (Icon Badge & Glowing Date Pill) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Holographic verified badge icon
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.05),
                  border: Border.all(
                    color: isHovered
                        ? accent.withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.08),
                    width: 1.2,
                  ),
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  color: isHovered ? accent : Colors.white54,
                  size: 18,
                ),
              ),

              // Glowing Date Badge Pill
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isHovered
                        ? accent.withValues(alpha: 0.25)
                        : Colors.white.withValues(alpha: 0.06),
                    width: 1,
                  ),
                ),
                child: Text(
                  cert.date.toUpperCase(),
                  style: TextStyle(
                    color: isHovered ? accent : Colors.white60,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // --- Certificate Title ---
          AnimatedDefaultTextStyle(
            duration: 300.ms,
            style: TextStyle(
              color: isHovered ? accent : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              letterSpacing: 0.4,
            ),
            child: Text(
              cert.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 4),

          // --- Organization Name ---
          Text(
            cert.organization,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // --- Skills Badge Wrap ---
          if (skillList.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: skillList.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.02),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      color: AppConstants.bodyTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],

          const Spacer(),

          // --- Action Link Button ---
          InkWell(
            onTap: () {
              launchUrl(Uri.parse(cert.credential),
                  mode: LaunchMode.externalApplication);
            },
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: 250.ms,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isHovered
                    ? accent.withValues(alpha: 0.12)
                    : accent.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isHovered
                      ? accent.withValues(alpha: 0.45)
                      : accent.withValues(alpha: 0.18),
                  width: 1.1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Verify Credentials',
                    style: TextStyle(
                      color: isHovered
                          ? Colors.white
                          : accent.withValues(alpha: 0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: isHovered ? 0.125 : 0.0,
                    duration: 200.ms,
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      color: isHovered
                          ? accent
                          : accent.withValues(alpha: 0.8),
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

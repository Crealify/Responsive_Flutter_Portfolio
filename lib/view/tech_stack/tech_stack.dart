import 'package:flutter/material.dart';
import 'package:anilbhattarai_portfolio/res/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'components/premium_integrations.dart';
import 'components/tech_stack_marquee.dart';
import '../../res/components/section_header.dart';

class TechStackView extends StatelessWidget {
  const TechStackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'Tech Stack', title: '& Integrations'),
        const SizedBox(height: AppConstants.spacing40),

        // Premium Integrations Section
        const PremiumIntegrationsSection(),

        const SizedBox(height: 80),

        // The Marquee Section for the rest of the stack
        Center(
          child: Text(
            'My Everyday Stack',
            style: GoogleFonts.outfit(
              color: bodyTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ).animate().fade(duration: 800.ms).slideY(begin: 0.3),
        ),
        // Center(
        //   child: Text(
        //     'Development Toolkit',
        //     style: GoogleFonts.outfit(
        //       color: bodyTextColor,
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //       letterSpacing: 1.2,
        //     ),
        //   ).animate().fade(duration: 800.ms).slideY(begin: 0.3),
        // ),
        const SizedBox(height: 30),
        const TechStackMarquee(),
      ],
    );
  }
}

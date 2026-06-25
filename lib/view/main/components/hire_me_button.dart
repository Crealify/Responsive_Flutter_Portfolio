import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'business_contact_modal.dart';

/// Call-to-action button that triggers a dropdown menu of contact channels
/// including a custom business form dialog, WhatsApp, and LinkedIn.
class HireMeButton extends StatefulWidget {
  final bool isCompact;
  const HireMeButton({super.key, this.isCompact = false});

  @override
  State<HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<HireMeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isCompact = widget.isCompact;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton<String>(
        // tooltip: 'Hire Me',
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.10),
            width: 1.2,
          ),
        ),
        color:
            const Color(0xFF0C192C), // Matching premium slate blue card color
        onSelected: (value) async {
          // Track hire me click
          Get.find<PortfolioController>().trackAction('hire_me_click');

          if (value == 'contact') {
            showBusinessContactDialog(context);
          } else if (value == 'whatsapp') {
            launchUrl(Uri.parse('https://wa.me/+9779867294376'),
                mode: LaunchMode.externalApplication);
          } else if (value == 'linkedin') {
            launchUrl(Uri.parse('https://linkedin.com/in/crealify'),
                mode: LaunchMode.externalApplication);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'contact',
            child: Row(
              children: [
                const Icon(Icons.mail_rounded,
                    color: Color(0xFFEF4444), size: 18), // Vibrant Red
                const SizedBox(width: 12),
                Text(
                  'Business Contact',
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.90),
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'whatsapp',
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_rounded,
                    color: Color(0xFF10B981), size: 18), // Emerald Green
                const SizedBox(width: 12),
                Text(
                  'WhatsApp',
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.90),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'linkedin',
            child: Row(
              children: [
                const Icon(Icons.link_rounded,
                    color: Color(0xFF06B6D4), size: 18), // Brand Cyan
                const SizedBox(width: 12),
                Text(
                  'LinkedIn',
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.90),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
        ],
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.03 : 1.0,
            _isHovered ? 1.03 : 1.0,
            1.0,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 12 : 18, vertical: isCompact ? 6 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF8B5CF6), // Premium Violet
                Color(0xFF06B6D4), // Brand Cyan
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B5CF6)
                    .withValues(alpha: _isHovered ? 0.40 : 0.20),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Text(
            "Hire Me",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              fontSize: isCompact ? 11.5 : 13.0,
            ),
          ),
        ),
      ),
    );
  }
}

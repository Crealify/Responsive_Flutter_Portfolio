
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../res/components/image_viewer.dart';
import 'experience_card_content.dart';

/// Color palette cycling for experience cards — alternates by index
/// for a lively, premium visual rhythm.
final List<Color> _cardAccents = [
  const Color(0xFF00FFD2), // cyber cyan
  const Color(0xFFFF00A0), // neon pink
  const Color(0xFF9B5FFE), // electric violet
  const Color(0xFFFFA640), // amber gold
];

class ExperienceStack extends StatefulWidget {
  final int index;
  final ValueChanged<bool>? onHover;
  const ExperienceStack({super.key, required this.index, this.onHover});

  @override
  State<ExperienceStack> createState() => _ExperienceStackState();
}

class _ExperienceStackState extends State<ExperienceStack> {
  bool _isHovered = false;

  // void _setHovered(bool h) {
  //   setState(() => _isHovered = h);
  //   widget.onHover?.call(h);
  // }

  Color get _accent => _cardAccents[widget.index % _cardAccents.length];

  @override
  Widget build(BuildContext context) {
    final exp = Get.find<PortfolioController>().experiences[widget.index];

    // Company field stores "Name\nLocation" — split cleanly
    final companyParts = exp.company.split('\n');
    final companyName =
        companyParts.isNotEmpty ? companyParts[0].trim() : exp.company;
    final location = companyParts.length > 1 ? companyParts[1].trim() : '';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_isHovered ? (widget.index % 2 == 0 ? 0.03 : -0.03) : 0.0)
          ..rotateX(_isHovered ? 0.015 : 0.0),
        transformAlignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Get.find<PortfolioController>()
                .trackAction('experience_click_${exp.company}');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageViewer(image: exp.image)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withValues(alpha: 0.7), // Fast opaque glass alternative
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? _accent.withValues(alpha: 0.35)
                    : Colors.white.withValues(alpha: 0.06),
                width: 1.2,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.12),
                    blurRadius: 40,
                    spreadRadius: -4,
                    offset: const Offset(0, 12),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Removed expensive BackdropFilter for silky smooth 60fps scrolling

                  // Animated radial glow backing
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: 400.ms,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: _isHovered ? 1.6 : 0.8,
                          colors: [
                            _accent.withValues(alpha: _isHovered ? 0.07 : 0.0),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Card content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ExperienceCardContent(
                      isHovered: _isHovered,
                      exp: exp,
                      accent: _accent,
                      companyName: companyName,
                      location: location,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

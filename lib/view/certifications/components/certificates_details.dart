import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'certificate_content.dart';

final List<Color> _certAccents = [
  const Color(0xFFFF00A0), // Neon Pink
  const Color(0xFF00FFD2), // Cyber Cyan
  const Color(0xFF9B5FFE), // Electric Violet
  const Color(0xFF00FF87), // Emerald Mint
];

class CertificateStack extends StatefulWidget {
  final int index;
  const CertificateStack({super.key, required this.index});

  @override
  State<CertificateStack> createState() => _CertificateStackState();
}

class _CertificateStackState extends State<CertificateStack> {
  bool _isHovered = false;

  Color get _accent => _certAccents[widget.index % _certAccents.length];

  @override
  Widget build(BuildContext context) {
    final cert = Get.find<PortfolioController>().certifications[widget.index];

    // Split skills string into a list of clean, visual tags
    final List<String> skillList = cert.skills
        .split(RegExp(r'[·•,;]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_isHovered ? (widget.index % 2 == 0 ? 0.025 : -0.025) : 0.0)
          ..rotateX(_isHovered ? 0.015 : 0.0)
          ..setTranslationRaw(0.0, _isHovered ? -6.0 : 0.0, 1.0),
        transformAlignment: Alignment.center,
        height: 245,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0F172A).withValues(alpha: _isHovered ? 0.90 : 0.75),
                const Color(0xFF0F172A).withValues(alpha: _isHovered ? 0.75 : 0.60),
              ],
            ),
            border: Border.all(
              color: _isHovered
                  ? _accent.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: _accent.withValues(alpha: 0.12),
                  blurRadius: 25,
                  spreadRadius: -4,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Stack(
            children: [
              // Interactive Gradient Glow
              Positioned.fill(
                child: AnimatedContainer(
                  duration: 400.ms,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: _isHovered ? 1.3 : 0.6,
                      colors: [
                        _accent.withValues(alpha: _isHovered ? 0.08 : 0.0),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              CertificateContent(
                cert: cert,
                isHovered: _isHovered,
                accent: _accent,
                skillList: skillList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

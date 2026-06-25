import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:anilbhattarai_portfolio/view_model/getx_controllers/portfolio_controller.dart';
import 'package:anilbhattarai_portfolio/view_model/responsive.dart';
import 'project_info_widgets.dart';

final List<Color> _projectAccents = [
  const Color(0xFF00FFD2), // Cyber Cyan
  const Color(0xFFFF00A0), // Neon Pink
  const Color(0xFF9B5FFE), // Electric Violet
  const Color(0xFF00FF87), // Emerald Mint
  const Color(0xFFFFA640), // Sunset Amber
];

class ProjectStack extends StatefulWidget {
  final int index;
  const ProjectStack({super.key, required this.index});

  @override
  State<ProjectStack> createState() => _ProjectStackState();
}

class _ProjectStackState extends State<ProjectStack> {
  bool _isHovered = false;
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    _mousePos.dispose();
    super.dispose();
  }

  Color get _accent => _projectAccents[widget.index % _projectAccents.length];

  @override
  Widget build(BuildContext context) {
    final proj = Get.find<PortfolioController>().projects[widget.index];
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isMobile = Responsive.isMobile(context);
    final bool isWide = !isMobile;
    final bool isCompactWide = isWide && screenWidth < 1400;

    final double mainPadding = isCompactWide ? 16.0 : 24.0;

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        onHover: (e) => _mousePos.value = e.localPosition,
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_isHovered ? (widget.index % 2 == 0 ? 0.02 : -0.02) : 0.0)
          ..rotateX(_isHovered ? 0.01 : 0.0)
          ..translateByDouble(0.0, _isHovered ? -8.0 : 0.0, 0.0, 1.0),
        transformAlignment: Alignment.center,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0F172A).withValues(alpha: _isHovered ? 0.90 : 0.75), // Fast opaque glass alternative
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
              // Removed expensive BackdropFilter for silky smooth 60fps scrolling

              // Dynamic Glowing Halo Follower (Mouse Spotlight)
              if (_isHovered)
                Positioned(
                  left: 0,
                  top: 0,
                  child: ValueListenableBuilder<Offset>(
                    valueListenable: _mousePos,
                    builder: (context, pos, child) {
                      return Transform.translate(
                        offset: Offset(pos.dx - 150, pos.dy - 150),
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Use static RadialGradient instead of BoxShadow for GPU performance
                            gradient: RadialGradient(
                              colors: [
                                _accent.withValues(alpha: 0.18),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 1.0],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // Subtile dot grid mesh pattern
              Positioned.fill(
                child: Opacity(
                  opacity: 0.03,
                  child: Image.asset(
                    'assets/images/project_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),

              // Card Inner Layout
              Padding(
                padding: EdgeInsets.all(mainPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- macOS Terminal Header Window controls ---
                    ProjectTerminalHeader(
                      proj: proj,
                      isHovered: _isHovered,
                      accent: _accent,
                    ),

                    SizedBox(height: isCompactWide ? 16 : 24),

                    // --- Adaptive Body (Wide Bento vs Standard Column) ---
                    if (isWide)
                      WideBentoLayout(
                        proj: proj,
                        isHovered: _isHovered,
                        accent: _accent,
                        isCompactWide: isCompactWide,
                      )
                    else
                      StandardBentoLayout(
                        proj: proj,
                        isHovered: _isHovered,
                        accent: _accent,
                      ),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

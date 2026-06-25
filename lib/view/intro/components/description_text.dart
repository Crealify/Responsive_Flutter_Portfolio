import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'package:anilbhattarai_portfolio/view_model/responsive.dart';

class AnimatedDescriptionText extends StatefulWidget {
  const AnimatedDescriptionText({
    super.key,
    required this.start,
    required this.end,
  });

  final double start;
  final double end;

  @override
  State<AnimatedDescriptionText> createState() =>
      _AnimatedDescriptionTextState();
}

class _AnimatedDescriptionTextState extends State<AnimatedDescriptionText> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);
  final ValueNotifier<Offset> _mousePosition =
      ValueNotifier<Offset>(Offset.zero);

  @override
  void dispose() {
    _isHovered.dispose();
    _mousePosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = Responsive.isExtraLargeScreen(context)
        ? 700
        : Responsive.isDesktop(context)
            ? 600
            : Responsive.isTablet(context)
                ? 500
                : MediaQuery.sizeOf(context).width * 0.8;

    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerHover: (event) => _mousePosition.value = event.localPosition,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The base text layer
          RepaintBoundary(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.only(left: 0, right: 10),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: maxWidth,
                  child: _buildRichText(context, widget.end),
                ),
              ),
            ),
          ),

          // The interactive glowing layers (Rebuilds efficiently)
          Positioned.fill(
            child: ValueListenableBuilder<bool>(
              valueListenable: _isHovered,
              builder: (context, isHovered, child) {
                if (!isHovered) return const SizedBox.shrink();
                return ValueListenableBuilder<Offset>(
                  valueListenable: _mousePosition,
                  builder: (context, mousePos, child) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Interactive Spotlight Effect
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Transform.translate(
                            offset:
                                Offset(mousePos.dx - 125, mousePos.dy - 125),
                            child: IgnorePointer(
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFF06B6D4)
                                          .withValues(alpha: 0.15),
                                      const Color(0xFF8B5CF6)
                                          .withValues(alpha: 0.05),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // iOS Premium Magnifier Loupe Effect
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Transform.translate(
                            offset: Offset(mousePos.dx - 65, mousePos.dy - 55),
                            child: IgnorePointer(
                              child: RawMagnifier(
                                decoration: MagnifierDecoration(
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                        color:
                                            Colors.white.withValues(alpha: 0.2),
                                        width: 1.5),
                                  ),
                                  // Removed heavy BoxShadows for massive performance boost
                                ),
                                size: const Size(130,
                                    42), // Slimmer, classic iOS text selection height
                                magnificationScale: 1.8,
                                focalPointOffset: const Offset(0,
                                    34), // Center of magnifier is dy-55+21 = dy-34, so focal offset is +34
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildRichText(BuildContext context, double fontSize) {
    return Obx(() {
      final hc = Get.find<PortfolioController>().heroConfig.value;
      return Text(
        hc.description,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white70,
          fontSize: fontSize,
          height: 1.6,
          fontFamily: 'Outfit',
        ),
      );
    });
  }
}

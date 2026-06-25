import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/components/image_viewer.dart';
import '../../../../res/constants.dart';
import '../../../../model/college_memory_model.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'memory_card_widgets.dart';

/// Highly optimized memory showcase card.
/// Removes expensive BackdropFilter and AnimatedBuilders for silky smooth 60fps scrolling.
class MemoryCard extends StatefulWidget {
  final CollegeMemory memory;
  final ValueChanged<bool>? onHoverChanged;

  const MemoryCard({
    super.key,
    required this.memory,
    this.onHoverChanged,
  });

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Widget _buildErrorPlaceholder() {
    return Container(color: Colors.black12, child: const Center(child: Icon(Icons.image, color: Colors.white54, size: 40)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 320,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Visual Card (underneath, ignored for hit-testing)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 300,
            child: IgnorePointer(
              child: RepaintBoundary(
                child: AnimatedScale(
                  scale: _isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    transform: Matrix4.translationValues(0, _isHovered ? -12 : 0, 0),
                    child: SizedBox(
                      width: 240,
                      height: 300,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: _isHovered
                                    ? [BoxShadow(color: AppConstants.primaryColor.withValues(alpha: 0.35), blurRadius: 30, spreadRadius: 2)]
                                    : [],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _isHovered
                                      ? [AppConstants.primaryColor, AppConstants.secondaryColor, AppConstants.activeIconColor]
                                      : [Colors.white.withValues(alpha: 0.15), Colors.white.withValues(alpha: 0.05)],
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(1.5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22.5),
                                child: Container(
                                  color: AppConstants.bgColor,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Hero(
                                        tag: widget.memory.imagePath,
                                        child: widget.memory.imagePath.startsWith('http')
                                            ? Image.network(widget.memory.imagePath, fit: BoxFit.cover,
                                                errorBuilder: (c, e, s) => _buildErrorPlaceholder())
                                            : Image.asset(widget.memory.imagePath, fit: BoxFit.cover,
                                                errorBuilder: (c, e, s) => _buildErrorPlaceholder()),
                                      ),
                                      Positioned.fill(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                                              stops: const [0.4, 1.0],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: MemoryCardFooter(
                                          title: widget.memory.title,
                                          isVertical: widget.memory.isVertical,
                                          isHovered: _isHovered,
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        height: 2,
                                        child: MemoryShimmerLine(animation: _shimmerController),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Interactive Target
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 300,
            child: MouseRegion(
              onEnter: (_) { setState(() => _isHovered = true); widget.onHoverChanged?.call(true); },
              onExit: (_) { setState(() => _isHovered = false); widget.onHoverChanged?.call(false); },
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Get.find<PortfolioController>().trackAction('memory_click_${widget.memory.title}');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewer(image: widget.memory.imagePath)));
                },
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.transparent)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

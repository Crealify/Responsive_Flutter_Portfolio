import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/constants.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class FeedbackCard extends StatefulWidget {
  final String name;
  final String role;
  final String feedback;
  final int rating;
  final double? width;
  final bool isEqualHeight;

  const FeedbackCard({
    super.key,
    required this.name,
    required this.role,
    required this.feedback,
    required this.rating,
    this.width,
    this.isEqualHeight = false,
  });

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  bool _isHovered = false;

  Widget _buildFeedbackText() {
    return Text(
      widget.feedback,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontFamily: 'Outfit',
        color: Colors.white.withValues(alpha: 0.75),
        height: 1.5,
        fontStyle: FontStyle.italic,
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PortfolioController>().trackAction('view_feedback_${widget.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Brand Violet color for hover borders and glows
    final Color hoverColor = const Color(0xFF8B5CF6);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: widget.width,
          padding: const EdgeInsets.all(AppConstants.spacing24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0C192C).withValues(alpha: 0.85), // Premium metallic slate blue
                const Color(0xFF060D1A).withValues(alpha: 0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered 
                  ? hoverColor.withValues(alpha: 0.5) 
                  : Colors.white.withValues(alpha: 0.08),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                    ? hoverColor.withValues(alpha: 0.15) 
                    : Colors.black.withValues(alpha: 0.10),
                blurRadius: _isHovered ? 30 : 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: index < widget.rating ? Colors.amber : Colors.white10,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacing16),
              if (widget.isEqualHeight)
                Expanded(child: _buildFeedbackText())
              else
                _buildFeedbackText(),
              const SizedBox(height: AppConstants.spacing24),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                      ),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: AppConstants.spacing16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.role,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

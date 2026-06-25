import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../res/constants.dart';
import 'video_dialog.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FeaturedVideoCard extends StatefulWidget {
  final String videoId;
  final String title;
  final double width;
  final int index;

  const FeaturedVideoCard({
    super.key,
    required this.videoId,
    required this.title,
    required this.width,
    required this.index,
  });

  @override
  State<FeaturedVideoCard> createState() => _FeaturedVideoCardState();
}

class _FeaturedVideoCardState extends State<FeaturedVideoCard> {
  YoutubePlayerController? _controller;
  bool _isHovered = false;

  Color get _accentColor {
    switch (widget.index % 3) {
      case 0: return const Color(0xFF3B82F6);
      case 1: return const Color(0xFF06B6D4);
      case 2: return const Color(0xFF8B5CF6);
      default: return const Color(0xFF3B82F6);
    }
  }

  void _initController() {
    if (_controller != null) return;
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(showControls: false, mute: true, showVideoAnnotations: false, loop: true),
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  void _showVideoDialog(BuildContext context) {
    _controller?.pauseVideo();
    Get.dialog(
      VideoDialog(
        videoId: widget.videoId,
        title: widget.title,
        accentColor: _accentColor,
        isHovered: _isHovered,
        controller: _controller,
      ),
    ).then((_) {
      if (_isHovered) _controller?.playVideo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() { _isHovered = true; _initController(); });
        Get.find<PortfolioController>().trackAction('video_preview_${widget.videoId}');
      },
      onExit: (_) { if (mounted) setState(() => _isHovered = false); },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showVideoDialog(context),
        child: AnimatedScale(
          scale: _isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: widget.width,
            transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
            decoration: BoxDecoration(
              color: AppConstants.cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered ? _accentColor.withValues(alpha: 0.65) : Colors.white.withValues(alpha: 0.08),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _accentColor.withValues(alpha: _isHovered ? 0.25 : 0.0),
                  blurRadius: _isHovered ? 35 : 12,
                  spreadRadius: _isHovered ? -2 : -6,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoThumbnail(
                  videoId: widget.videoId,
                  accentColor: _accentColor,
                  isHovered: _isHovered,
                  controller: _controller,
                ),
                _buildCardFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(color: const Color(0xFF09162A).withValues(alpha: 0.80)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.5, fontFamily: 'Outfit', letterSpacing: 0.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.video_library_rounded, size: 11, color: _accentColor.withValues(alpha: 0.8)),
                    const SizedBox(width: 4),
                    Text('YouTube Showcase',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 9.5, fontFamily: 'Outfit', fontWeight: FontWeight.w500, letterSpacing: 0.5)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AnimatedContainer(
            duration: 250.ms,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered ? _accentColor.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.02),
              border: Border.all(
                color: _isHovered ? _accentColor.withValues(alpha: 0.35) : Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Icon(Icons.arrow_forward_rounded, size: 14, color: _isHovered ? _accentColor : Colors.white60),
          ),
        ],
      ),
    );
  }
}

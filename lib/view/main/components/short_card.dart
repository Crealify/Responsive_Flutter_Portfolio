import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../../res/constants.dart';
import '../../../../model/shorts_model.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class ShortCard extends StatefulWidget {
  final ShortsModel short;
  final double width;

  const ShortCard({
    super.key,
    required this.short,
    required this.width,
  });

  @override
  State<ShortCard> createState() => _ShortCardState();
}

class _ShortCardState extends State<ShortCard> {
  YoutubePlayerController? _controller;
  bool _isHovered = false;

  void _initController() {
    if (_controller != null || !widget.short.isYouTube || widget.short.videoId.isEmpty) return;
    
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.short.videoId,
      autoPlay: true, // Start playing on first hover
      params: const YoutubePlayerParams(
        showControls: false,
        mute: true,
        loop: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (mounted) {
          setState(() {
            _isHovered = true;
            _initController();
          });
        }
        _controller?.playVideo();
        _controller?.unMute();
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
        _controller?.pauseVideo();
        _controller?.mute();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Get.find<PortfolioController>().trackAction('shorts_click_${widget.short.title}');
          launchUrl(Uri.parse(widget.short.url), mode: LaunchMode.externalApplication);
        },
        child: RepaintBoundary(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            decoration: BoxDecoration(
              color: AppConstants.cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withValues(alpha: _isHovered ? 0.2 : 0.0),
                  blurRadius: _isHovered ? 25 : 10,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (widget.short.isYouTube && _controller != null)
                        IgnorePointer(
                          child: YoutubePlayer(
                            controller: _controller!,
                            aspectRatio: 9 / 16,
                          ),
                        )
                      else
                        Container(
                          color: Colors.black12,
                          child: Center(
                            child: Icon(
                              widget.short.isYouTube ? Icons.play_circle_fill : Icons.facebook,
                              color: Colors.white30,
                              size: 40,
                            ),
                          ),
                        ),
                      if (!_isHovered || !widget.short.isYouTube)
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                            ),
                          ),
                        ),
                      if (!_isHovered)
                        const Center(
                          child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.spacing8),
                  child: Text(
                    widget.short.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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

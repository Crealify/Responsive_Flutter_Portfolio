import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

/// Fullscreen video modal shown when user taps the card
class VideoDialog extends StatelessWidget {
  final String videoId;
  final String title;
  final Color accentColor;
  final bool isHovered;
  final YoutubePlayerController? controller;

  const VideoDialog({
    super.key,
    required this.videoId,
    required this.title,
    required this.accentColor,
    required this.isHovered,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: TweenAnimationBuilder<double>(
        duration: 400.ms,
        curve: Curves.easeOutBack,
        tween: Tween(begin: 0.85, end: 1.0),
        builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
        child: Container(
          width: 960,
          constraints: const BoxConstraints(maxWidth: 960),
          decoration: BoxDecoration(
            color: const Color(0xFF08080E),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: accentColor.withValues(alpha: 0.35), width: 1.5),
            boxShadow: [
              BoxShadow(color: accentColor.withValues(alpha: 0.25), blurRadius: 40, spreadRadius: 2),
              BoxShadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 60, spreadRadius: 10),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.02),
                  border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor,
                        boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.5), blurRadius: 8, spreadRadius: 1)],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(title,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Outfit', letterSpacing: 0.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 22),
                      color: Colors.white70,
                      hoverColor: Colors.white10,
                      style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () {
                        Get.back();
                        if (isHovered) controller?.playVideo();
                      },
                    ),
                  ],
                ),
              ),
              // Full Player
              AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: YoutubePlayerController.fromVideoId(
                    videoId: videoId,
                    params: const YoutubePlayerParams(showControls: true, mute: false, showVideoAnnotations: true, showFullscreenButton: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Thumbnail overlay — shows a static image + play button, or live preview on hover
class VideoThumbnail extends StatelessWidget {
  final String videoId;
  final Color accentColor;
  final bool isHovered;
  final YoutubePlayerController? controller;

  const VideoThumbnail({
    super.key,
    required this.videoId,
    required this.accentColor,
    required this.isHovered,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          if (isHovered && controller != null)
            IgnorePointer(child: YoutubePlayer(controller: controller!, aspectRatio: 16 / 9))
          else
            Image.network(
              'https://img.youtube.com/vi/$videoId/maxresdefault.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.black26, child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 50)),
            ),
          if (!isHovered) ...[
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.black.withValues(alpha: 0.15), Colors.black.withValues(alpha: 0.55)],
                  center: Alignment.center,
                  radius: 0.9,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [accentColor.withValues(alpha: 0.85), accentColor.withValues(alpha: 0.4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.45), blurRadius: 18, spreadRadius: 2)],
                  border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1.5),
                ),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 38),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(end: const Offset(1.08, 1.08), duration: 1000.ms, curve: Curves.easeInOut),
            ),
          ],
          if (isHovered)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.4), width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(end: const Offset(1.5, 1.5), duration: 600.ms, curve: Curves.easeInOut),
                    const SizedBox(width: 5),
                    const Text('PREVIEW',
                        style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                  ],
                ),
              ).animate().fadeIn(duration: 200.ms).scale(begin: const Offset(0.9, 0.9)),
            ),
        ],
      ),
    );
  }
}

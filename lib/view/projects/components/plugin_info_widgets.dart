import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Terminal-style header row with macOS window dots + pub.dev badge
class PluginTerminalHeader extends StatelessWidget {
  final bool isHovered;
  final Color accent;

  const PluginTerminalHeader({super.key, required this.isHovered, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _dot(Colors.red, isHovered),
            const SizedBox(width: 5),
            _dot(Colors.yellow, isHovered),
            const SizedBox(width: 5),
            _dot(Colors.green, isHovered),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accent.withValues(alpha: 0.2), width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_user_rounded, size: 10, color: accent),
              const SizedBox(width: 4),
              Text('PUB.DEV',
                  style: TextStyle(color: accent, fontSize: 8.5, fontWeight: FontWeight.bold, letterSpacing: 0.5, fontFamily: 'Outfit')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot(Color color, bool hovered) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: hovered ? 0.75 : 0.4)),
    );
  }
}

/// Copyable `flutter pub add` command line row
class PluginCommandLine extends StatelessWidget {
  final int index;
  final bool isHovered;
  final Color accent;
  final BuildContext context;

  const PluginCommandLine({
    super.key,
    required this.index,
    required this.isHovered,
    required this.accent,
    required this.context,
  });

  String get _command => index == 0
      ? 'flutter pub add bottom_navigation_animated_notch_bar'
      : 'flutter pub add lifecycle_guard';

  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: _command));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_outline_rounded, color: accent, size: 18),
                const SizedBox(width: 8),
                const Text('Installation command copied!',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Outfit')),
              ],
            ),
            backgroundColor: const Color(0xFF0F0F1A),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            width: 280,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: accent.withValues(alpha: 0.3)),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: isHovered ? 0.35 : 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHovered ? accent.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.04),
            width: 0.8,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.chevron_right_rounded, size: 14, color: accent),
            const SizedBox(width: 4),
            Expanded(
              child: Text(_command,
                  style: const TextStyle(color: Colors.white70, fontSize: 9.5, fontFamily: 'Courier', fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            Icon(Icons.copy_rounded, size: 11, color: isHovered ? accent.withValues(alpha: 0.8) : Colors.white54),
          ],
        ),
      ),
    );
  }
}

/// Pub.dev metrics row: Likes / Pub Points / Popularity
class PluginMetricsRow extends StatelessWidget {
  final int index;
  final Color accent;
  final Color secAccent;

  const PluginMetricsRow({super.key, required this.index, required this.accent, required this.secAccent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.015),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03), width: 0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _metric('LIKES', index == 0 ? '100%' : '98%', accent)),
          Expanded(child: _metric('PUB POINTS', '140 / 140', secAccent)),
          Expanded(child: _metric('POPULARITY', index == 0 ? '99%' : '95%', accent)),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white38, fontSize: 7.5, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 3),
        Text(value,
            style: TextStyle(color: color.withValues(alpha: 0.95), fontSize: 10.5, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A wrapper that defers rendering and animation of its child until it scrolls into view.
/// This creates a true cascading "river flow" effect for lists and tree structures.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final int index;
  final String baseKey;
  final Duration delay;

  const ScrollReveal({
    super.key,
    required this.child,
    required this.index,
    required this.baseKey,
    this.delay = Duration.zero,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;
  bool _hasFired = false;

  @override
  void initState() {
    super.initState();
    final safeDelay = Duration(milliseconds: widget.delay.inMilliseconds.clamp(0, 150));
    // Fallback for Flutter Web fast scrolling where VisibilityDetector might miss the frame.
    // Reduced from 500ms to 100ms so items never appear "blank" for long.
    Future.delayed(const Duration(milliseconds: 100) + safeDelay, () {
      if (mounted && !_hasFired) {
        setState(() {
          _hasFired = true;
          _isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('scroll_reveal_${widget.baseKey}_${widget.index}'),
      onVisibilityChanged: (info) {
        if (!_hasFired && info.visibleFraction > 0.01) {
          _hasFired = true;
          // Cap the delay so fast scrolling doesn't cause empty screen voids
          final safeDelay = Duration(milliseconds: widget.delay.inMilliseconds.clamp(0, 150));
          Future.delayed(safeDelay, () {
            if (mounted) {
              setState(() {
                _isVisible = true;
              });
            }
          });
        }
      },
      child: widget.child.animate(target: _isVisible ? 1 : 0)
          .fadeIn(duration: 800.ms, curve: Curves.easeOut)
          .slideY(begin: 0.15, end: 0, curve: Curves.easeOutExpo),
    );
  }
}

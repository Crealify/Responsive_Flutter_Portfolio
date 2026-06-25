import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class PremiumSmoothScroll extends StatefulWidget {
  final ScrollController controller;
  final Widget Function(BuildContext context, ScrollPhysics physics) builder;

  const PremiumSmoothScroll({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  State<PremiumSmoothScroll> createState() => _PremiumSmoothScrollState();
}

class _PremiumSmoothScrollState extends State<PremiumSmoothScroll> {
  double _scrollTarget = 0.0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    // Only trigger on key down or hold-to-repeat
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      final key = event.logicalKey;

      if (key == LogicalKeyboardKey.arrowUp) {
        // Futuristic, buttery glide for arrow keys
        _doSmoothScroll(-200.0, durationMs: 400, curve: Curves.easeOutExpo);
        return true;
      } else if (key == LogicalKeyboardKey.arrowDown) {
        _doSmoothScroll(200.0, durationMs: 400, curve: Curves.easeOutExpo);
        return true;
      }
    }
    return false;
  }

  void _doSmoothScroll(
    double delta, {
    int durationMs = 350,
    Curve curve = Curves.easeOutQuart,
  }) {
    if (!widget.controller.hasClients) return;

    if (!_isScrolling) {
      _scrollTarget = widget.controller.offset;
    }

    _scrollTarget += delta;
    final double maxScroll = widget.controller.position.maxScrollExtent;
    _scrollTarget = _scrollTarget.clamp(0.0, maxScroll);

    // If already scrolling, reduce duration to simulate continuous momentum instead of sticky restarts
    final int effectiveDuration = _isScrolling ? (durationMs * 0.6).toInt() : durationMs;
    _isScrolling = true;

    // Buttery smooth ease-out animation aiming for 120 FPS rendering
    widget.controller
        .animateTo(
      _scrollTarget,
      duration: Duration(milliseconds: effectiveDuration),
      curve: curve,
    )
        .then((_) {
      if (mounted && (widget.controller.offset - _scrollTarget).abs() < 1.0) {
        _isScrolling = false;
      }
    });
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final double delta = event.scrollDelta.dy;
      if (delta == 0) return;

      // Trackpads send a constant stream of small deltas (e.g., 1 to 20).
      // Mouse wheels send discrete, large chunks (e.g., 50 to 100+).
      // Let the native hardware handle trackpads perfectly without our interference!
      if (delta.abs() < 35.0) return;

      // Consume the event to override the default slow browser mouse wheel scroll
      GestureBinding.instance.pointerSignalResolver.register(event, (PointerSignalEvent e) {
        final double multiplier = (e.kind == PointerDeviceKind.mouse) ? 4.5 : 2.0;
        // Use an exponential curve for mouse wheels so it glides perfectly
        _doSmoothScroll(delta * multiplier, durationMs: 400, curve: Curves.easeOutExpo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // We apply the listener globally. For touch events, PointerSignal is not triggered,
    // so it falls back to the native physics.
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: widget.builder(context, const WaterflowScrollPhysics()),
    );
  }
}

/// Custom scroll physics for mobile that creates a "waterflow" perfect glide.
/// Preserves 1:1 finger tracking, but adds a buttery momentum when flicking.
class WaterflowScrollPhysics extends BouncingScrollPhysics {
  const WaterflowScrollPhysics({super.parent});

  @override
  WaterflowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return WaterflowScrollPhysics(parent: buildParent(ancestor));
  }


  // Enhance the coasting momentum when the user releases their finger (flicks).
  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // Boost the velocity slightly for an effortless, water-like coasting feel
    final double enhancedVelocity = velocity * 1.15;
    return super.createBallisticSimulation(position, enhancedVelocity);
  }

  // A premium, slightly looser spring for the bounce at the edges
  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50,
        stiffness: 150,
        damping: 0.95,
      );
}

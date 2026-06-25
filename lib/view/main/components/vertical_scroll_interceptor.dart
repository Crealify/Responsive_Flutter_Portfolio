import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../view_model/controller.dart';

/// Intercepts vertical scroll signals (mouse wheel) over horizontal lists,
/// and delegates them to the page's global vertical scroll controller.
class VerticalScrollInterceptor extends StatelessWidget {
  final Widget child;

  const VerticalScrollInterceptor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          final double dy = pointerSignal.scrollDelta.dy;
          final double dx = pointerSignal.scrollDelta.dx;
          if (dy.abs() > dx.abs()) {
            final mainController = globalScrollController;
            if (mainController.hasClients) {
              final double multiplier = (pointerSignal.kind == PointerDeviceKind.mouse) ? 4.5 : 2.0;
              final newOffset = mainController.offset + (dy * multiplier);
              mainController.animateTo(
                newOffset.clamp(0.0, mainController.position.maxScrollExtent),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuart,
              );
            }
            GestureBinding.instance.pointerSignalResolver.register(pointerSignal, (event) {});
          }
        }
      },
      child: child,
    );
  }
}

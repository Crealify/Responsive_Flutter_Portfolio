import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

/// A subtle glowing halo that follows the mouse cursor on desktop screens.
class MouseHalo extends StatefulWidget {
  const MouseHalo({super.key});

  @override
  State<MouseHalo> createState() => _MouseHaloState();
}

class _MouseHaloState extends State<MouseHalo> {
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    _mousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (event) => _mousePos.value = event.position,
      child: ValueListenableBuilder<Offset>(
        valueListenable: _mousePos,
        builder: (context, pos, child) {
          return Transform.translate(
            offset: pos + const Offset(-200, -200),
            child: child!,
          );
        },
        child: RepaintBoundary(
          child: IgnorePointer(
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppConstants.primaryColor.withValues(alpha: 0.12),
                    AppConstants.secondaryColor.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

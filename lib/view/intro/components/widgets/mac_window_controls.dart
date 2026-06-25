import 'package:flutter/material.dart';

/// Grid of white dots for the header decoration.
class HeaderDotGrid extends StatelessWidget {
  const HeaderDotGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (r) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(10, (c) {
            return Container(
              margin: const EdgeInsets.all(2),
              width: 1.5,
              height: 1.5,
              decoration: const BoxDecoration(
                color: Colors.white12,
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      }),
    );
  }
}

class CrazyMacWindowControls extends StatefulWidget {
  const CrazyMacWindowControls({super.key});

  @override
  State<CrazyMacWindowControls> createState() => _CrazyMacWindowControlsState();
}

class _CrazyMacWindowControlsState extends State<CrazyMacWindowControls> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDot(const Color(0xFFEF4444), 0, Icons.close_rounded),
          const SizedBox(width: 8),
          _buildDot(const Color(0xFFF59E0B), 1, Icons.remove_rounded),
          const SizedBox(width: 8),
          _buildDot(const Color(0xFF10B981), 2, Icons.open_in_full_rounded),
        ],
      ),
    );
  }

  Widget _buildDot(Color color, int index, IconData icon) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.elasticOut,
      transform: Matrix4.translationValues(
        0.0,
        _isHovered ? -4.0 : 0.0,
        0.0,
      )..scaleByDouble(_isHovered ? 1.4 : 1.0, _isHovered ? 1.4 : 1.0, 1.0, 1.0),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: _isHovered
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.8),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.0),
                  blurRadius: 0,
                  spreadRadius: 0,
                )
              ],
      ),
      child: Center(
        child: AnimatedOpacity(
          opacity: _isHovered ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            icon,
            size: 8,
            color: Colors.black.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

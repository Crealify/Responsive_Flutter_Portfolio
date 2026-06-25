import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectShowcaseMockup extends StatelessWidget {
  final dynamic proj;
  final bool isHovered;
  final Color accent;
  final bool isCompactWide;

  const ProjectShowcaseMockup({
    super.key,
    required this.proj,
    required this.isHovered,
    required this.accent,
    required this.isCompactWide,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(isHovered ? -0.06 : -0.03)
          ..rotateX(isHovered ? 0.04 : 0.02),
        transformAlignment: Alignment.center,
        child: Container(
          height: isCompactWide ? 100 : 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered ? accent.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: isHovered ? 0.15 : 0.05),
                blurRadius: 20,
                spreadRadius: -2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.expand,
              children: [
                proj.image.startsWith('http')
                    ? Image.network(
                        proj.image,
                        fit: BoxFit.cover,
                        cacheWidth: 600,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFF0F0F1A),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                                color: accent,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, _, _) => _buildFallbackMockup(),
                      )
                    : Image.asset(
                        proj.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _buildFallbackMockup(),
                      ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.transparent, accent.withValues(alpha: isHovered ? 0.25 : 0.1)],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: 350.ms,
                  color: isHovered ? accent.withValues(alpha: 0.1) : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackMockup() {
    return Container(
      color: const Color(0xFF0F0F1A),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.terminal_rounded, color: accent.withValues(alpha: 0.5), size: 28),
            const SizedBox(height: 6),
            const Text(
              'SHOWCASE FRAME',
              style: TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

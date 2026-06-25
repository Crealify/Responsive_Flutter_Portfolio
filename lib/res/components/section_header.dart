import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../view_model/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String prefix;
  final String title;

  const SectionHeader({
    super.key,
    required this.prefix,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                prefix,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: _getFontSize(context),
                    ),
              ),
              const SizedBox(width: 10),
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                  ).createShader(bounds);
                },
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: _getFontSize(context),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    .animate()
    .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
    .slideX(begin: -0.15, duration: 800.ms, curve: Curves.easeOutCubic);
  }

  double _getFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) return 48;
    if (Responsive.isTablet(context)) return 36;
    return 28;
  }
}

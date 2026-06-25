import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class AppPreviewGalleryHeader extends StatelessWidget {
  const AppPreviewGalleryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "App Previews",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Outfit',
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Swipe to see demo applications built with Flutter.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 12.5,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    );
  }
}

class AppPreviewGalleryIndicator extends StatelessWidget {
  final int count;
  final int currentPage;

  const AppPreviewGalleryIndicator({
    super.key,
    required this.count,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 6,
          width: currentPage == index ? 28 : 6,
          decoration: BoxDecoration(
            color: currentPage == index ? AppConstants.secondaryColor : Colors.white12,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              if (currentPage == index)
                BoxShadow(
                  color: AppConstants.secondaryColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

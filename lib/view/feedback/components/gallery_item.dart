import 'package:flutter/material.dart';
import '../../../res/constants.dart';
import '../../../model/app_preview_model.dart';

/// An individual device mockup item in the gallery, supporting auto-scrolling browser frames.
class GalleryItem extends StatelessWidget {
  final AppPreviewModel app;
  final int index;
  final ScrollController scrollController;
  final VoidCallback onStartAnimateScroller;

  const GalleryItem({
    super.key,
    required this.app,
    required this.index,
    required this.scrollController,
    required this.onStartAnimateScroller,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = app.imageUrl.startsWith('http');
    final Color color =
        Colors.primaries[app.name.length % Colors.primaries.length];

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacing8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // 1. Themed Background / Placeholder
              if (!isNetworkImage)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.8),
                        color.withValues(alpha: 0.4)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      app.imageUrl.contains('shopping')
                          ? Icons.shopping_bag_rounded
                          : app.imageUrl.contains('fitness')
                              ? Icons.fitness_center_rounded
                              : app.imageUrl.contains('people')
                                  ? Icons.people_rounded
                                  : Icons.apps_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),

              // 2. Smart Device Frame (for Network Images)
              if (isNetworkImage)
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1), width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Image.network(
                          app.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2));
                          },
                        ),
                      ),
                    ),
                  ),
                ),

              // 3. Browser/Phone Notch Accent
              if (isNetworkImage)
                Positioned(
                  top: 15,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),

              // 4. Premium Floating Title Badge
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515).withValues(alpha: 0.95), // Solid sleek color instead of expensive blur
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                      child: Text(
                        app.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Outfit',
                          letterSpacing: 0.2,
                        ),
                      ),
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

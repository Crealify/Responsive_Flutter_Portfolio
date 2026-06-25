import 'package:flutter/material.dart';
import '../../res/constants.dart';
import '../../view_model/responsive.dart';
import '../../res/components/section_header.dart';
import 'components/feedback_form.dart';
import 'components/feedback_grid.dart';
import 'components/app_preview_gallery.dart';

/// A section showcasing client testimonials and app previews.
class ClientFeedback extends StatelessWidget {
  const ClientFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(prefix: 'What ', title: 'Clients Say'),
        const SizedBox(height: AppConstants.spacing40),
        const FeedbackGrid(),
        const SizedBox(height: AppConstants.spacing64),
        
        Responsive.isDesktop(context)
            ? const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: AppPreviewGallery()),
                  SizedBox(width: AppConstants.spacing40),
                  Expanded(child: FeedbackForm()),
                ],
              )
            : const Column(
                children: [
                  AppPreviewGallery(),
                  SizedBox(height: AppConstants.spacing40),
                  FeedbackForm(),
                ],
              ),
      ],
    );
  }
}

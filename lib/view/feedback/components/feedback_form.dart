import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';
import '../../../services/mock_data_service.dart';
import '../../../model/client_model.dart';
import '../../../res/components/premium_button.dart';
import 'feedback_form_components.dart';

/// An elegant form that lets users submit testimonials directly to the backend.
class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  int _rating = 5;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitReview() async {
    if (_nameController.text.isEmpty || _feedbackController.text.isEmpty) {
      Get.snackbar(
        'Wait', 
        'Name and Feedback are required!',
        backgroundColor: Colors.orangeAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final review = Client(
        id: '',
        name: _nameController.text,
        role: _roleController.text.isEmpty ? 'Client' : _roleController.text,
        feedback: _feedbackController.text,
        rating: _rating,
        order: DateTime.now().millisecondsSinceEpoch, // Sort by newest
      );

      await MockDataService().addClient(review);
      
      // Refresh the controller to instantly show the new review in the grid
      Get.find<PortfolioController>().refreshClients();

      if (mounted) {
        Get.snackbar(
          'Success',
          'Thank you for your review! It is now live.',
          backgroundColor: Colors.greenAccent.withValues(alpha: 0.8),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
        );
        _nameController.clear();
        _roleController.clear();
        _feedbackController.clear();
        setState(() {
          _rating = 5;
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit review: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _buildStars(bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isSelected = index < _rating;
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
          icon: Icon(
            isSelected ? Icons.star_rounded : Icons.star_border_rounded,
            color: isSelected ? const Color(0xFFFFB300) : Colors.white54,
            size: isMobile ? 20 : 28,
          ).animate(target: isSelected ? 1.0 : 0.0)
           .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.15, 1.15), duration: 200.ms),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 2),
          visualDensity: isMobile ? VisualDensity.compact : null,
          constraints: const BoxConstraints(),
          splashRadius: isMobile ? 16 : 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);
    final double formWidth = isDesktop ? 700 : double.infinity;

    return Container(
      width: formWidth,
      padding: EdgeInsets.all(
        isMobile
            ? AppConstants.spacing16
            : AppConstants.spacing32,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F18).withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withValues(alpha: 0.12),
            blurRadius: 40,
            spreadRadius: -4,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          const FeedbackHeader(),
          const SizedBox(height: AppConstants.spacing24),
          FeedbackTextField(hint: "Name", controller: _nameController, icon: Icons.person_outline_rounded),
          const SizedBox(height: 20),
          FeedbackTextField(hint: "Role / Company", controller: _roleController, icon: Icons.work_outline_rounded),
          const SizedBox(height: AppConstants.spacing24),
          
          // Star Rating Row (Always on one line, scaling down if needed)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  "Overall Rating",
                  style: TextStyle(
                    color: Colors.white70, 
                    fontWeight: FontWeight.w600, 
                    fontSize: 13,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: _buildStars(isMobile),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          FeedbackTextField(
            hint: "Your Feedback",
            controller: _feedbackController,
            icon: Icons.message_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: AppConstants.spacing32),
          
          Align(
            alignment: Alignment.centerRight,
            child: PremiumButton(
              text: 'Submit Review',
              onTap: _submitReview,
              isLoading: _isSubmitting,
              trailingIcon: const Icon(Icons.send_rounded, color: Colors.white, size: 14)
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .move(begin: Offset.zero, end: const Offset(2.0, 0.0), duration: 800.ms, curve: Curves.easeInOut),
            ),
          )
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.05);
  }
}

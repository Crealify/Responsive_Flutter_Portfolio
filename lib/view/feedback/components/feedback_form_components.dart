import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

class FeedbackHeader extends StatelessWidget {
  const FeedbackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Leave a Review",
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
            "Share your thoughts and rate your experience directly below.",
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

class FeedbackTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData? icon;
  final int maxLines;

  const FeedbackTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.white, 
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Outfit',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 13, fontFamily: 'Outfit'),
        prefixIcon: maxLines == 1 && icon != null ? Icon(icon, color: Colors.white60, size: 18) : null,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05), // Distinctly visible frosted background
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)), // High visibility outline
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppConstants.secondaryColor, width: 1.5), // Vibrant focus outline
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../res/constants.dart';

class BusinessContactMessageField extends StatelessWidget {
  final TextEditingController controller;

  const BusinessContactMessageField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      minLines: 3,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w500,
        fontFamily: 'Outfit',
      ),
      cursorColor: Colors.white,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Message is required' : null,
      decoration: InputDecoration(
        hintText: 'Write your message here...',
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 13, fontFamily: 'Outfit'),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppConstants.secondaryColor, width: 1.5),
        ),
        errorStyle: const TextStyle(
          color: Color(0xFFFF4D8D),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'Outfit',
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF4D8D), width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF4D8D), width: 1.5),
        ),
      ),
    );
  }
}

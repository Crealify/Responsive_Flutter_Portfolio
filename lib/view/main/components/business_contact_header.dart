import 'package:flutter/material.dart';

/// The premium header bar for the business contact dialog.
class BusinessContactHeader extends StatelessWidget {
  final VoidCallback onClose;
  const BusinessContactHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        children: [
          // Gmail-style icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.mail_rounded, color: Color(0xFFEA4335), size: 16),
          ),
          const SizedBox(width: 12),
          const Text(
            'Business Contact',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          // Minimize-style close button
          GestureDetector(
            onTap: onClose,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded, color: Colors.white54, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

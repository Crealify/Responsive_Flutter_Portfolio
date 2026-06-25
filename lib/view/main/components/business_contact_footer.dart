import 'package:flutter/material.dart';
import '../../../res/constants.dart';

/// The bottom footer of the business contact dialog, handling submission state indicators.
class BusinessContactFooter extends StatelessWidget {
  final bool sent;
  final bool isSending;
  final VoidCallback onSend;

  const BusinessContactFooter({
    super.key,
    required this.sent,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.15),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          // Formatting hint
          const Text(
            'Securely sent to the backend',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
          const Spacer(),
          // Send Button
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: sent
                ? Container(
                    key: const ValueKey('sent'),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 16),
                        SizedBox(width: 6),
                        Text('Sent!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                : GestureDetector(
                    key: const ValueKey('send'),
                    onTap: isSending ? null : onSend,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor,
                            AppConstants.secondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppConstants.primaryColor.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: isSending
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.send_rounded, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../res/constants.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AreaInfoText extends StatelessWidget {
  const AreaInfoText({
    super.key, 
    required this.title, 
    required this.text, 
    this.onTap,
    this.icon,
    this.copyText,
  });

  final String title;
  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final String? copyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          hoverColor: Colors.white.withValues(alpha: 0.02),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacing16,
              vertical: 6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacing16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          if (onTap != null) ...[
                            IconButton(
                              icon: const Icon(Icons.copy_rounded, size: 14),
                              color: Colors.white.withValues(alpha: 0.4),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              tooltip: 'Copy',
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: copyText ?? text));
                                Get.snackbar(
                                  'Copied!',
                                  '$title copied to clipboard.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstants.primaryColor.withValues(alpha: 0.2),
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 2),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.arrow_outward_rounded,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text,
                          style: TextStyle(
                            color: onTap != null ? AppConstants.secondaryColor : Colors.white.withValues(alpha: 0.9),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

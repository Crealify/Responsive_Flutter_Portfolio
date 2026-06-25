import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypingStatsBar extends StatelessWidget {
  final DateTime? startTime;
  final int wps;
  final double accuracy;

  const TypingStatsBar({
    super.key,
    required this.startTime,
    required this.wps,
    required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (startTime != null)
            Row(
              children: [
                _richStatText("WPS: ", "$wps"),
                const SizedBox(width: 16),
                _richStatText("Accuracy: ", "${accuracy.toInt()}%"),
              ],
            )
          else
            const Spacer(),
          const Text(
            "UTF-8",
            style: TextStyle(
              color: Colors.white12,
              fontSize: 10,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _richStatText(String label, String value) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.firaCode(fontSize: 11),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.white38,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Color(0xFF06B6D4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

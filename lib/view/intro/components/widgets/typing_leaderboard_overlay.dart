import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../../res/constants.dart';
import '../../../../../view_model/getx_controllers/portfolio_controller.dart';

class TypingLeaderboardOverlay extends StatefulWidget {
  final int finalWps;
  final VoidCallback onReset;
  final bool initialIsScoreSaved;
  final ValueChanged<bool> onScoreSaved;

  const TypingLeaderboardOverlay({
    super.key,
    required this.finalWps,
    required this.onReset,
    required this.initialIsScoreSaved,
    required this.onScoreSaved,
  });

  @override
  State<TypingLeaderboardOverlay> createState() => _TypingLeaderboardOverlayState();
}

class _TypingLeaderboardOverlayState extends State<TypingLeaderboardOverlay> {
  late bool _isScoreSaved;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isScoreSaved = widget.initialIsScoreSaved;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: const Color(0xFF07111F).withValues(alpha: 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber, size: 40),
                const SizedBox(height: 8),
                const Text(
                  "LEADERBOARD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    letterSpacing: 2,
                  ),
                ),
                if (!_isScoreSaved)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _nameController,
                              autofocus: true,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: "Enter Name",
                                hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: AppConstants.primaryColor, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppConstants.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.cloud_upload_outlined, color: AppConstants.primaryColor, size: 20),
                            onPressed: () async {
                              if (_nameController.text.isNotEmpty) {
                                final controller = Get.find<PortfolioController>();
                                await controller.addLeaderboardEntry(_nameController.text, widget.finalWps);
                                setState(() {
                                  _isScoreSaved = true;
                                });
                                widget.onScoreSaved(true);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 8),
                Obx(() {
                  final controller = Get.find<PortfolioController>();
                  final list = controller.leaderboard;
                  return Column(
                    children: List.generate(list.length.clamp(0, 3), (index) {
                      final entry = list[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${index + 1}. ${entry['name']}",
                              style: const TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Inter'),
                            ),
                            Text(
                              "${entry['score']} WPS",
                              style: const TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                }),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: widget.onReset,
                  child: const Text("TRY AGAIN", style: TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
                ),
              ],
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack).fadeIn(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants.dart';

class CustomErrorScreen extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRefresh;

  const CustomErrorScreen({
    super.key,
    this.title = "Something went wrong",
    this.message = "Please check your connection and try again.",
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the error happens inside a small component (like the TypingEngine card)
        if (constraints.maxHeight < 350 || constraints.maxWidth < 300) {
          return Center(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF07111F).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraCode',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontFamily: 'FiraCode',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Full Screen Error View
        return Material(
          color: AppConstants.bgColor,
          child: SafeArea(
            child: Stack(
              children: [
                // Top Refresh Button
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      onTap: onRefresh ?? () {},
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Click here to\nRefresh',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.refresh, color: Colors.white54, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Center Content
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Custom Sad Wi-Fi Icon
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.wifi,
                                size: 100,
                                color: Color(0xFF3B5998),
                              ),
                              Positioned(
                                right: 15,
                                bottom: 25,
                                child: Transform.rotate(
                                  angle: 0.2,
                                  child: Container(
                                    height: 50,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3B5998),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(radius: 2, backgroundColor: Colors.white),
                                            CircleAvatar(radius: 2, backgroundColor: Colors.white),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Icon(Icons.horizontal_rule, color: Colors.white, size: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

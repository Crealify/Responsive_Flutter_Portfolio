import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

class MyPortfolioText extends StatelessWidget {
  const MyPortfolioText({super.key, required this.start, required this.end});
  final double start;
  final double end;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Semantics(
          header: true,
          child: Obx(() {
            final hc = Get.find<PortfolioController>().heroConfig.value;
            return RepaintBoundary(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        fontSize: end, // Use fixed 'end' size
                        fontFamily: 'Outfit',
                        letterSpacing: -1.5,
                      ),
                  children: [
                    TextSpan(text: '${hc.greeting} '),
                    TextSpan(
                      text: hc.name,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: const Color(0xFF06B6D4).withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                          ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 400.0, 70.0)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}

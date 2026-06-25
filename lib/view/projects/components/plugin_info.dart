import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../../../res/constants.dart';
import '../../../res/components/premium_button.dart';
import 'plugin_info_widgets.dart';

final List<Color> _pluginAccents = [const Color(0xFF00FFD2), const Color(0xFFFFA640)];
final List<Color> _pluginSecAccents = [const Color(0xFF00FF87), const Color(0xFF9B5FFE)];

class PluginStack extends StatefulWidget {
  final int index;
  const PluginStack({super.key, required this.index});

  @override
  State<PluginStack> createState() => _PluginStackState();
}

class _PluginStackState extends State<PluginStack> {
  bool _isHovered = false;

  Color get _accent => _pluginAccents[widget.index % _pluginAccents.length];
  Color get _secAccent => _pluginSecAccents[widget.index % _pluginSecAccents.length];

  @override
  Widget build(BuildContext context) {
    final plugin = Get.find<PortfolioController>().plugins[widget.index];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_isHovered ? (widget.index % 2 == 0 ? 0.025 : -0.025) : 0.0)
          ..rotateX(_isHovered ? 0.015 : 0.0)
          ..translateByDouble(0.0, _isHovered ? -8.0 : 0.0, 0.0, 1.0),
        transformAlignment: Alignment.center,
        height: 370,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0F172A).withValues(alpha: _isHovered ? 0.90 : 0.75),
                const Color(0xFF0F172A).withValues(alpha: _isHovered ? 0.75 : 0.60),
              ],
            ),
            border: Border.all(
              color: _isHovered ? _accent.withValues(alpha: 0.45) : Colors.white.withValues(alpha: 0.06),
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(color: _accent.withValues(alpha: 0.12), blurRadius: 30, spreadRadius: -4, offset: const Offset(0, 10)),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedContainer(
                  duration: 400.ms,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: _isHovered ? 1.4 : 0.6,
                      colors: [_accent.withValues(alpha: _isHovered ? 0.09 : 0.0), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PluginTerminalHeader(isHovered: _isHovered, accent: _accent),
                    const SizedBox(height: 14),
                    AnimatedDefaultTextStyle(
                      duration: 300.ms,
                      style: TextStyle(color: _isHovered ? _accent : Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Outfit', letterSpacing: 0.3),
                      child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(plugin.name, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ),
                    const SizedBox(height: 6),
                    Text(plugin.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: AppConstants.bodyTextColor, fontSize: 12.5, height: 1.45),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12),
                    PluginCommandLine(
                      index: widget.index,
                      isHovered: _isHovered,
                      accent: _accent,
                      context: context,
                    ),
                    const SizedBox(height: 14),
                    PluginMetricsRow(index: widget.index, accent: _accent, secAccent: _secAccent),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: plugin.technologies.map((tech) {
                          return Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.02),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.06), width: 0.8),
                            ),
                            child: Text(tech, style: const TextStyle(color: AppConstants.bodyTextColor, fontSize: 10, fontWeight: FontWeight.w500)),
                          );
                        }).toList(),
                      ),
                    ),
                    const Spacer(),
                    PremiumButton(
                      text: 'VIEW PACKAGE',
                      icon: Icons.arrow_outward_rounded,
                      gradient: [_accent.withValues(alpha: 0.8), _accent.withValues(alpha: 0.4)],
                      onTap: () {
                        Get.find<PortfolioController>().trackAction('plugin_card_click_${plugin.name}');
                        launchUrl(Uri.parse(plugin.link), mode: LaunchMode.externalApplication);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

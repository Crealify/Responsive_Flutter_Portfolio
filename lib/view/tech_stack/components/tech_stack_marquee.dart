import 'package:flutter/material.dart';
import 'package:anilbhattarai_portfolio/res/constants.dart';
import 'package:anilbhattarai_portfolio/view_model/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/pagination_strips.dart';
import '../tech_data.dart';

class TechStackMarquee extends StatefulWidget {
  const TechStackMarquee({super.key});

  @override
  State<TechStackMarquee> createState() => _TechStackMarqueeState();
}

class _TechStackMarqueeState extends State<TechStackMarquee> with SingleTickerProviderStateMixin {
  bool _showAll = false;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Group skills by category for a structured display
    final Map<String, List<TechSkill>> groupedSkills = {};
    for (var skill in TechData.techStack) {
      if (!groupedSkills.containsKey(skill.category)) {
        groupedSkills[skill.category] = [];
      }
      groupedSkills[skill.category]!.add(skill);
    }

    final allEntries = groupedSkills.entries.toList();
    final displayedEntries = _showAll ? allEntries : allEntries.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...displayedEntries.asMap().entries.map((entry) {
          final index = entry.key;
          final categoryEntry = entry.value;
          return _buildCategoryRow(context, categoryEntry.key, categoryEntry.value, index);
        }),
        if (allEntries.length > 4)
          AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: _showAll
                ? CollapseStrip(onTap: () => setState(() => _showAll = false))
                : RevealStrip(
                    hiddenCount: allEntries.length - 4,
                    shimmerController: _shimmerController,
                    onTap: () => setState(() => _showAll = true),
                    itemName: 'category',
                  ),
          ),
      ],
    );
  }

  Widget _buildCategoryRow(BuildContext context, String category, List<TechSkill> skills, int categoryIndex) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: isMobile ? 12 : 24),
      padding: EdgeInsets.all(isMobile ? 12 : (isTablet ? 20 : 24)),
      decoration: BoxDecoration(
        color: AppConstants.surfaceL2.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryTitle(category, isMobile),
          SizedBox(height: isMobile ? 12 : 20),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: isMobile ? 6 : 12,
              runSpacing: isMobile ? 6 : 12,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: skills.map((s) => _buildSkillChip(s, category, categoryIndex, isMobile)).toList(),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 600.ms).slideY(begin: 0.1);
  }

  Widget _buildCategoryTitle(String category, bool isMobile) {
    return Row(
      children: [
        Container(
          width: isMobile ? 3 : 4,
          height: isMobile ? 18 : 24,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            category,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(TechSkill skill, String category, int categoryIndex, bool isMobile) {
    // Generate an alternating color based on the category's row index
    final List<Color> glowColors = [
      const Color(0xFF8B5CF6), // Violet
      const Color(0xFF06B6D4), // Cyan
    ];
    final Color chipColor = glowColors[categoryIndex % glowColors.length];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 16, vertical: isMobile ? 5 : 10),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1), // Tinted glass effect instead of solid black
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: chipColor.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 4 : 6,
            height: isMobile ? 4 : 6,
            decoration: BoxDecoration(
              color: chipColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: chipColor, blurRadius: 4),
              ],
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scaleXY(begin: 0.8, end: 1.2, duration: 1000.ms),
          const SizedBox(width: 8),
            Text(
              skill.name,
              style: GoogleFonts.inter(
                color: AppConstants.bodyTextColor,
                fontSize: isMobile ? 11 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
      ),
    ).animate().shimmer(delay: 1.seconds, duration: 2.seconds, color: Colors.white10);
  }
}

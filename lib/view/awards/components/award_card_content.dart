import 'package:flutter/material.dart';
import '../../../../model/award_model.dart';
import '../../../../res/constants.dart';

class AwardCardContent extends StatelessWidget {
  final AwardModel award;
  final Color accentColor;

  const AwardCardContent({
    super.key,
    required this.award,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.2),
                  ),
                ),
                child: award.iconUrl.isNotEmpty
                    ? Image.network(
                        award.iconUrl,
                        width: 24,
                        height: 24,
                        color: accentColor,
                        errorBuilder: (_, _, _) => Icon(
                            Icons.workspace_premium_rounded,
                            color: accentColor,
                            size: 24),
                      )
                    : Icon(Icons.workspace_premium_rounded,
                        color: accentColor,
                        size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  award.date,
                  style: const TextStyle(
                    color: AppConstants.subtitleColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            award.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            award.issuer,
            style: TextStyle(
              color: accentColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            award.description,
            style: const TextStyle(
              color: AppConstants.subtitleColor,
              fontSize: 12,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

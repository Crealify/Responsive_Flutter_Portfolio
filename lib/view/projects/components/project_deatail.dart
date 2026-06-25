import 'package:anilbhattarai_portfolio/view/projects/components/project_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/getx_controllers/portfolio_controller.dart';

import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';

class ProjectDetail extends StatelessWidget {
  final int index;
  const ProjectDetail({super.key, required this.index});
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              Get.find<PortfolioController>().projects[index].name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Responsive.isMobile(context)
              ? const SizedBox(
                  height: AppConstants.spacing8,
                )
              : const SizedBox(
                  height: AppConstants.spacing16,
                ),
          Text(
            Get.find<PortfolioController>().projects[index].description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppConstants.bodyTextColor,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: defaultPadding/2,),
          ProjectLinks(index: index,),
          const SizedBox(height: defaultPadding/2,),
        ],
      ),
    );
  }
}

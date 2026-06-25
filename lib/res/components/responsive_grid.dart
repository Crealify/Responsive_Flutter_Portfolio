import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../constants.dart';

class ResponsiveGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final int crossAxisCount;
  final double ratio;

  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.crossAxisCount,
    this.ratio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: spacing16,
      crossAxisSpacing: spacing16,
      children: List.generate(
        itemCount,
        (index) => StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: itemBuilder(context, index),
        ),
      ),
    );
  }
}

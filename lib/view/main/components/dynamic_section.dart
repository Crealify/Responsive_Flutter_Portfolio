import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../view_model/getx_controllers/portfolio_controller.dart';

/// Internal wrapper to carry a section name through the build tree.
class NamedSection extends StatelessWidget {
  final String name;
  final Widget child;
  const NamedSection({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) => child;
}

/// A lightweight dynamic section wrapper that mounts the section
/// and tracks analytics. It no longer hides content with Opacity(0) 
/// because that causes blank screens during hyper-fast scrolling.
/// (Inner elements use ScrollReveal for entrance animations).
class DynamicSection extends StatefulWidget {
  final Widget child;
  final String animKey;
  final int index;
  final String sectionName;
  // The GlobalKey from the original NamedSection that marks this section
  // for programmatic scroll navigation (scrollToSection).
  final GlobalKey? sectionKey;

  const DynamicSection({
    super.key,
    required this.child,
    required this.animKey,
    required this.index,
    required this.sectionName,
    this.sectionKey,
  });

  @override
  State<DynamicSection> createState() => _DynamicSectionState();
}

class _DynamicSectionState extends State<DynamicSection> {
  bool _hasTracked = false;

  @override
  Widget build(BuildContext context) {
    // Always render the child so it isn't blank during fast scrolling.
    // The internal ScrollReveal widgets will handle the actual fade-in animations.
    final Widget sectionChild = widget.sectionKey != null
        ? KeyedSubtree(
            key: widget.sectionKey,
            child: RepaintBoundary(child: widget.child),
          )
        : RepaintBoundary(child: widget.child);

    return VisibilityDetector(
      key: Key(widget.animKey),
      onVisibilityChanged: (info) {
        if (!_hasTracked && info.visibleFraction > 0.01) {
          _hasTracked = true;
          // Track section view in analytics once it becomes visible
          if (!widget.sectionName.startsWith('divider')) {
            try {
              Get.find<PortfolioController>().trackAction('view_${widget.sectionName}');
            } catch (e) {
              // Ignore if controller isn't mounted yet
            }
          }
        }
      },
      child: sectionChild,
    );
  }
}


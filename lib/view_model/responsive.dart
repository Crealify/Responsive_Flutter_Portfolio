import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key,
      required this.desktop,
      required this.largeMobile,
      required this.mobile,
      required this.tablet,
      this.extraLargeScreen});
  final Widget desktop;
  final Widget? largeMobile;
  final Widget mobile;
  final Widget? tablet;
  final Widget? extraLargeScreen;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isLargeMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 600 && MediaQuery.sizeOf(context).width < 800;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 800 && MediaQuery.sizeOf(context).width < 1000;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1000;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 1400;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width > 1400 && extraLargeScreen != null) {
      return extraLargeScreen!;
    } else if (width >= 1000) {
      return desktop;
    } else if (width >= 800 && tablet != null) {
      return tablet!;
    } else if (width >= 600 && largeMobile != null) {
      return largeMobile!;
    } else {
      return mobile;
    }
  }
}

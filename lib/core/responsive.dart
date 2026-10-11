import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1000;
  static double u(BuildContext c, double fraction) =>
      contentWidth(c) * fraction;
  static double width(BuildContext c) => MediaQuery.sizeOf(c).width;
  static double height(BuildContext c) => MediaQuery.sizeOf(c).height;

  static bool isTablet(BuildContext c) => width(c) >= tabletBreakpoint;
  static bool isWide(BuildContext c) => width(c) >= desktopBreakpoint;
  static bool isLandscape(BuildContext c) =>
      MediaQuery.orientationOf(c) == Orientation.landscape;

  static double w(BuildContext c, double fraction) => width(c) * fraction;
  static double h(BuildContext c, double fraction) => height(c) * fraction;
  static double contentWidth(BuildContext c) {
    final w = width(c);
    if (w >= desktopBreakpoint) return w * 0.5;
    if (w >= tabletBreakpoint) return w * 0.75;
    return w;
  }

  static double font(BuildContext c, double fraction) {
    final size = width(c) * fraction;
    final max = isTablet(c) ? 34.0 : 28.0;
    return size.clamp(12.0, max);
  }
}
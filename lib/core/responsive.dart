import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1000;

  static double width(BuildContext c) => MediaQuery.sizeOf(c).width;

  static double contentWidth(BuildContext c) {
    final w = width(c);
    if (w >= desktopBreakpoint) return w * 0.5;
    if (w >= tabletBreakpoint) return w * 0.75;
    return w;
  }

  static bool useTwoColumns(BuildContext c) {
    final landscape = MediaQuery.orientationOf(c) == Orientation.landscape;
    return width(c) >= desktopBreakpoint ||
        (width(c) >= tabletBreakpoint && landscape);
  }

  static double pageWidth(BuildContext c) =>
      useTwoColumns(c) ? width(c) * 0.9 : contentWidth(c);

  static double u(BuildContext c, double fraction) =>
      contentWidth(c) * fraction;

  static double font(BuildContext c, double fraction, {double max = 30}) =>
      (width(c) * fraction).clamp(12.0, max);
}
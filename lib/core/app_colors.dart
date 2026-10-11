import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static bool _isDark(BuildContext c) =>
      Theme.of(c).brightness == Brightness.dark;

  static Color success(BuildContext c) =>
      _isDark(c) ? const Color(0xFF6FD6A0) : const Color(0xFF1E8E5A);
}
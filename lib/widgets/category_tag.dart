import 'package:flutter/material.dart';
import '../core/responsive.dart';

class CategoryTag extends StatelessWidget {
  const CategoryTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.u(context, 0.03),
        vertical: Responsive.u(context, 0.012),
      ),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(Responsive.u(context, 0.02)),
      ),
      child: Text(
        '< $label />',
        style: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontWeight: FontWeight.w700,
          fontSize: Responsive.font(context, 0.032),
          color: scheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
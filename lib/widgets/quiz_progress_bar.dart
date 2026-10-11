import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/responsive.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.results,
    required this.currentIndex,
  });

  final List<bool?> results;
  final int currentIndex;

  Color _colorFor(BuildContext context, int i) {
    final scheme = Theme.of(context).colorScheme;
    final r = results[i];
    if (r == true) return AppColors.success(context);
    if (r == false) return scheme.error;
    if (i == currentIndex) return scheme.primary;
    return scheme.outlineVariant;
  }

  @override
  Widget build(BuildContext context) {
    final gap = Responsive.u(context, 0.005);
    return Row(
      children: [
        for (int i = 0; i < results.length; i++)
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: gap),
              height: Responsive.u(context, 0.02),
              decoration: BoxDecoration(
                color: _colorFor(context, i),
                borderRadius:
                BorderRadius.circular(Responsive.u(context, 0.01)),
              ),
            ),
          ),
      ],
    );
  }
}
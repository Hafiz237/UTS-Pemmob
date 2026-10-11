import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/responsive.dart';

enum OptionState { idle, correct, wrong, dimmed }

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.index,
    required this.text,
    required this.state,
    this.onTap,
  });

  final int index;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(Responsive.u(context, 0.035));

    final Color bg;
    final Color border;
    final Color badgeBg;
    final Color badgeFg;
    IconData? icon;

    switch (state) {
      case OptionState.correct:
        final c = AppColors.success(context);
        bg = c.withValues(alpha: 0.15);
        border = c;
        badgeBg = c;
        badgeFg = scheme.surface;
        icon = Icons.check_circle_rounded;
      case OptionState.wrong:
        bg = scheme.error.withValues(alpha: 0.12);
        border = scheme.error;
        badgeBg = scheme.error;
        badgeFg = scheme.surface;
        icon = Icons.cancel_rounded;
      case OptionState.idle:
      case OptionState.dimmed:
        bg = scheme.surfaceContainerLow;
        border = scheme.outlineVariant;
        badgeBg = scheme.primaryContainer;
        badgeFg = scheme.onPrimaryContainer;
    }

    final badgeSize = Responsive.u(context, 0.09);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: state == OptionState.dimmed ? 0.5 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: Border.all(color: border, width: 1.5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(Responsive.u(context, 0.035)),
              child: Row(
                children: [
                  Container(
                    width: badgeSize,
                    height: badgeSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius:
                      BorderRadius.circular(Responsive.u(context, 0.02)),
                    ),
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontWeight: FontWeight.w700,
                        fontSize: Responsive.font(context, 0.04),
                        color: badgeFg,
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.u(context, 0.035)),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: Responsive.font(context, 0.042),
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                  if (icon != null) Icon(icon, color: border),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
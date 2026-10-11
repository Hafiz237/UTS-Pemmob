import 'package:flutter/material.dart';
import '../core/responsive.dart';

class TerminalCard extends StatelessWidget {
  const TerminalCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dot = Responsive.u(context, 0.025);
    final gap = Responsive.u(context, 0.015);

    Widget dotWidget(Color color) => Container(
      width: dot,
      height: dot,
      margin: EdgeInsets.only(right: gap),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Responsive.u(context, 0.04)),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: scheme.surfaceContainerHighest,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.u(context, 0.035),
              vertical: Responsive.u(context, 0.025),
            ),
            child: Row(
              children: [
                dotWidget(const Color(0xFFFF5F57)),
                dotWidget(const Color(0xFFFEBC2E)),
                dotWidget(const Color(0xFF28C840)),
                SizedBox(width: gap),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.font(context, 0.03),
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Responsive.u(context, 0.05)),
            child: child,
          ),
        ],
      ),
    );
  }
}
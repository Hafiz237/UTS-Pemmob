import 'package:flutter/material.dart';
import '../core/responsive.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final fontSize = Responsive.font(context, 0.042);
    final radius = BorderRadius.circular(Responsive.u(context, 0.035));

    final style = ButtonStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Responsive.u(context, 0.035),
          horizontal: Responsive.u(context, 0.05),
        ),
      ),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
      ),
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: fontSize * 1.3),
          SizedBox(width: Responsive.u(context, 0.02)),
        ],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );

    return SizedBox(
      width: expand ? double.infinity : null,
      child: filled
          ? FilledButton(onPressed: onPressed, style: style, child: content)
          : OutlinedButton(onPressed: onPressed, style: style, child: content),
    );
  }
}
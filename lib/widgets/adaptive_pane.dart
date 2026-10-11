import 'package:flutter/material.dart';
import '../core/responsive.dart';

class AdaptivePane extends StatelessWidget {
  const AdaptivePane({super.key, required this.first, required this.second});

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    final gap = Responsive.u(context, 0.04);

    if (Responsive.useTwoColumns(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: first),
          SizedBox(width: gap),
          Expanded(child: second),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [first, SizedBox(height: gap), second],
    );
  }
}
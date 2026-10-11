import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.asset,
    required this.fallbackIcon,
    required this.size,
  });

  final String asset;
  final IconData fallbackIcon; 
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Icon(
        fallbackIcon,
        size: size,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CustomAppBar({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.85),
            colorScheme.surface.withOpacity(0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

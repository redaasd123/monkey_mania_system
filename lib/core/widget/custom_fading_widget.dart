import 'package:flutter/material.dart';

class CustomFadingWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const CustomFadingWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<CustomFadingWidget> createState() => _CustomFadingWidgetState();
}

class _CustomFadingWidgetState extends State<CustomFadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2), // ⬅️ أبطأ من 800 ms
  )..repeat(reverse: true);

  late final Animation<double> _fade = CurvedAnimation(
    parent: _ctrl,
    curve: Curves.easeInOut, // ⬅️ انتقال ناعم
  ).drive(Tween(begin: 0.2, end: 0.8)); // مدى الشفافية

  @override
  void initState() {
    super.initState();
    if (widget.delay > Duration.zero) {
      _ctrl.stop();
      Future.delayed(widget.delay, _ctrl.forward);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _fade, child: widget.child);
}

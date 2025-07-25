import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TypingThenShimmerLetters extends StatefulWidget {
  const TypingThenShimmerLetters({
    super.key,
    required this.text,

    /* ⚙️ السرعات القابلة للضبط */
    this.charDelay     = const Duration(milliseconds: 120),
    this.animDuration  = const Duration(milliseconds: 800),
    this.shimmerPeriod = const Duration(milliseconds: 1500),

    /* التنسيق */
    this.textStyle,
    this.baseColor     = const Color(0xFF003321), // Monkey Green
    this.highlightColor= const Color(0xFFFFFFFF), // Mania Peach
  });

  final String text;
  final Duration charDelay;
  final Duration animDuration;
  final Duration shimmerPeriod;
  final TextStyle? textStyle;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<TypingThenShimmerLetters> createState() => _TypingThenShimmerLettersState();
}

class _TypingThenShimmerLettersState extends State<TypingThenShimmerLetters>
    with SingleTickerProviderStateMixin {
  late final List<String> _chars = widget.text.split('');
  int _visible = 0;
  bool _showShimmer = false;
  Timer? _timer;

  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: widget.animDuration,
  );

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(widget.charDelay, (t) {
      if (_visible < _chars.length) {
        setState(() => _visible++);
        _ctrl.forward(from: 0);                // حركة للحرف الجديد
      } else {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) setState(() => _showShimmer = true);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle ??
        const TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

    /* بعد انتهاء الكتابة ➜ شيمر */
    if (_showShimmer) {
      return Shimmer.fromColors(
        baseColor: widget.baseColor,
        highlightColor: widget.highlightColor,
        period: widget.shimmerPeriod,
        child: Text(widget.text, style: style),
      );
    }

    /* أثناء الكتابة حرف‑بحرف */
    return Wrap(
      children: List.generate(_visible, (i) {
        final char = _chars[i] == ' ' ? '\u00A0' : _chars[i]; // space ثابت
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) => Opacity(
            opacity: _ctrl.value,
            child: Transform.translate(
              offset: Offset(0, 12 * (1 - _ctrl.value)), // صعود بسيط
              child: child!,
            ),
          ),
          child: Text(char,
              style: style.copyWith(color: widget.baseColor)),
        );
      }),
    );
  }
}

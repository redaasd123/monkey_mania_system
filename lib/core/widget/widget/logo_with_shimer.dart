import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../utils/constans.dart';

class LogoWithAnimatedText extends StatefulWidget {
  const LogoWithAnimatedText({super.key});

  @override
  State<LogoWithAnimatedText> createState() => _LogoWithAnimatedTextState();
}

class _LogoWithAnimatedTextState extends State<LogoWithAnimatedText>
    with TickerProviderStateMixin {
  late final AnimationController _entranceCtrl;
  late final AnimationController _breathCtrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _scale = Tween(begin: .9, end: 2.0).animate(
      CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutBack),
    );
    _fade = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeIn));

    _breathCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _rotation = Tween(
      begin: -0.03,
      end: 0.03,
    ).animate(CurvedAnimation(parent: _breathCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _breathCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([_entranceCtrl, _breathCtrl]),
          builder: (_, __) => Opacity(
            opacity: _fade.value,
            child: Transform.rotate(
              angle: _rotation.value * math.pi,
              child: Transform.scale(
                scale: _scale.value,
                child: const CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage(kTest),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        //  ColorChangingShimmerText(),
      ],
    );
  }
}


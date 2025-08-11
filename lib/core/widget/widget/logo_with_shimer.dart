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
  late final AnimationController _entranceCtrl; // Fade + Scale
  late final AnimationController _breathCtrl; // دوران هادئ
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    // ➊ دخول مرّة واحدة
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

    // ➋ دوران تنفّسي لا نهائى
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
            opacity: _fade.value, // يبقى بين 0→1 دائمًا
            child: Transform.rotate(
              angle: _rotation.value * math.pi, // تنفّس
              child: Transform.scale(
                scale: _scale.value, // دخول
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
        //  ColorChangingShimmerText(),         // النص المتلألئ
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*               نص Monkey Mania – شيمر + تبديل ألوان غير محدود              */
/* -------------------------------------------------------------------------- */

//class LogoWithAnimatedText extends StatefulWidget {
//   const LogoWithAnimatedText({super.key});
//
//   @override
//   State<LogoWithAnimatedText> createState() => _LogoWithAnimatedTextState();
// }
//
// class _LogoWithAnimatedTextState extends State<LogoWithAnimatedText>
//     with TickerProviderStateMixin {
//   late final AnimationController _logoCtrl;
//   late final Animation<double> _scale;
//   late final Animation<double> _fade;
//   late final Animation<double> _breath; // دوران خفيف "تنفّس"
//
//   @override
//   void initState() {
//     super.initState();
//
//     // يشغل مرة واحدة: Fade + Scale
//     _logoCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..forward();
//
//     _scale = Tween(begin: .6, end: 1.0)
//         .animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOutBack));
//
//     _fade = Tween(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeIn));
//
//     // بعد الانتهاء يبدأ دوران تنفّس بطيء لا نهائى
//     _breath = Tween(begin: -0.03, end: 0.03).animate(
//       CurvedAnimation(parent: _logoCtrl, curve: Curves.easeInOut),
//     )..addStatusListener((s) {
//       if (s == AnimationStatus.completed) {
//         _logoCtrl.reverse();
//       } else if (s == AnimationStatus.dismissed) {
//         _logoCtrl.forward();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _logoCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AnimatedBuilder(
//           animation: _logoCtrl,
//           builder: (_, __) => Opacity(
//             opacity: _fade.value,
//             child: Transform.rotate(
//               angle: _breath.value * math.pi,
//               child: Transform.scale(
//                 scale: _scale.value,
//                 child: const CircleAvatar(
//                   radius: 90,
//                   backgroundImage: AssetImage(kLogo),
//                   backgroundColor: Colors.transparent,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 14),
//         const _ColorChangingShimmerText(), // النص المتغير الألوان
//       ],
//     );
//   }
// }
//
// /*---------------- نص Monkey Mania يتغير ألوانه ----------------*/
//
// class _ColorChangingShimmerText extends StatefulWidget {
//   const _ColorChangingShimmerText();
//
//   @override
//   State<_ColorChangingShimmerText> createState() =>
//       _ColorChangingShimmerTextState();
// }
//
// class _ColorChangingShimmerTextState extends State<_ColorChangingShimmerText>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _ctrl;
//   final _combos = [
//     [Colors.green, Colors.lightGreenAccent],
//     [Colors.teal, Colors.cyanAccent],
//     [Colors.orange, Colors.amberAccent],
//     [Colors.purple, Colors.pinkAccent],
//   ];
//   int idx = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..addStatusListener((s) {
//       if (s == AnimationStatus.completed) {
//         setState(() => idx = (idx + 1) % _combos.length);
//         _ctrl.forward(from: 0);
//       }
//     })..forward();
//   }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = _combos[idx];
//     return Shimmer.fromColors(
//       baseColor: colors[0],
//       highlightColor: colors[1],
//       period: const Duration(seconds: 2),
//       child: const Text(
//         'Monkey Mania',
//         style: TextStyle(
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }
// }

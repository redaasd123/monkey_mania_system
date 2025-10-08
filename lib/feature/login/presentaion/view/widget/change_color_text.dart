import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:shimmer/shimmer.dart';

class ColorChangingShimmerText extends StatefulWidget {
  const ColorChangingShimmerText();

  @override
  State<ColorChangingShimmerText> createState() =>
      _ColorChangingShimmerTextState();
}

class _ColorChangingShimmerTextState extends State<ColorChangingShimmerText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final List<List<Color>> colorCombos = [
    [Colors.green, Colors.lightGreenAccent],
    [Colors.teal, Colors.cyanAccent],
    [Colors.orange, Colors.amberAccent],
    [Colors.purple, Colors.pinkAccent],
    [Colors.blue, Colors.lightBlueAccent],
    [Colors.redAccent, Colors.orangeAccent],
    [Colors.indigo, Colors.deepPurpleAccent],
    [Colors.lime, Colors.yellowAccent],
  ];
  int idx = 0;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              setState(() => idx = (idx + 1) % colorCombos.length);
              _ctrl.forward(from: 0);
            }
          })
          ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = colorCombos[idx];
    return Shimmer.fromColors(
      baseColor: colors[0],
      highlightColor: colors[1],
      period: const Duration(seconds: 2),
      child:  Text(
        LangKeys.appName.tr(),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

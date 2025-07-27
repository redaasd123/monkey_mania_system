import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme_color/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constans.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late final AnimationController _imageRotationController;
  late final Animation<double> _rotationAnimation;
  bool _showShimmer = false;

  @override
  void initState() {
    super.initState();

    _imageRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: -0.01, end: 0.01).animate(
      CurvedAnimation(
        parent: _imageRotationController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) setState(() => _showShimmer = true);
    });

    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
    });
  }

  @override
  void dispose() {
    _imageRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🌀 الشعار
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (_, child) => Transform.rotate(
                  angle: _rotationAnimation.value * math.pi,
                  child: ClipOval(
                    child: Image.asset(
                      kTest,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ✨ عنوان التطبيق
              _showShimmer
                  ? Shimmer.fromColors(
                baseColor: Colors.brown, // بني فاتح
                highlightColor: Colors.green, // بني أفتح
                period: const Duration(milliseconds: 1200),
                child: Text(
                  'Monkey Mania',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary, // يفضل تسيبها كده علشان التيكست يكون واضح لما الشيمر ينتهي
                  ),
                ),
              )
                  : DefaultTextStyle(
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      'Monkey Mania',
                      speed: const Duration(milliseconds: 120),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

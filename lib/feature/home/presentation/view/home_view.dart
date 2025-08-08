import 'package:flutter/material.dart';
import 'package:monkey_app/feature/home/presentation/view/widget/view/home_view_bode.dart';
import 'package:monkey_app/feature/splash/presentation/views/widgets/custom_app_bar.dart';
import '../../../../core/utils/my_app_drwer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(
      context,
    ).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: HomeViewBody(),
      backgroundColor: colorScheme.background,
      drawer: const MyAppDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/utils/my_app_drwer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;  // جلب اللون من الثيم الحالي

    return Scaffold(
      backgroundColor: colorScheme.background, // الخلفية حسب الثيم (فاتح أو داكن)
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: 30, color: colorScheme.onPrimary), // لون الأيقونة حسب الثيم
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        elevation: 0,
        backgroundColor: colorScheme.primary, // لون الـ AppBar حسب الثيم
      ),
      drawer: const MyAppDrawer(),
    );
  }
}

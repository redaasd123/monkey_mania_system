import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/utils/constans.dart';
import '../../feature/home/presentation/manager/theme_Cubit.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme; // جلب الـ colorScheme من الثيم

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,  // استخدام اللون الأساسي من الثيم
              colorScheme.secondary,  // استخدام اللون الثانوي من الثيم
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: colorScheme.onPrimary, // استخدام اللون من الثيم
                    child: Image.asset(kTest, height: 80),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LangKeys.appName.tr(),
                    style: TextStyle(
                      color: colorScheme.onBackground, // استخدام اللون المتوافق مع الخلفية
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white30),

            _buildDrawerItem(
              context,
              icon: Icons.school_outlined,
              text: LangKeys.school.tr(),
              onTap: () => GoRouter.of(context).push(AppRouter.kSchoolView),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.child_care,
              text: LangKeys.children.tr(),
              onTap: () => GoRouter.of(context).push(AppRouter.kChildrenSchool),
            ),

            _buildDrawerItem(
              onTap: () {
               GoRouter.of(context).push(AppRouter.kBillsView);
              },
              context,
              icon: Icons.account_balance_rounded,
              text: LangKeys.changeLanguage.tr(),
            ),

            _buildDrawerItem(
              onTap: () {
                Locale newLocale = context.locale.languageCode == 'en'
                    ? Locale('ar', 'EG')
                    : Locale('en', 'US');
                context.setLocale(newLocale);
              },
              context,
              icon: Icons.language,
              text: LangKeys.changeLanguage.tr(),
            ),


            _buildDrawerItem(
              context,
              icon: Icons.dark_mode,
              text: LangKeys.nightMode.tr(),
              onTap: () {
                context.read<ThemeCubit>().toggle();
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.exit_to_app,
              text: LangKeys.logOut.tr(),
              onTap: () async {
                await AuthHelper.clearAuthData();
                await AuthHelper.logOut();
                GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
              },
            ),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                "© 2025 Monkey App",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String text,
        required VoidCallback onTap,
      }) {
    final colorScheme = Theme.of(context).colorScheme; // جلب الـ colorScheme من الثيم

    return ListTile(
      leading: Icon(icon, color: colorScheme.onSurface), // اللون المناسب للأيقونات حسب الثيم
      title: Text(
        text,
        style: TextStyle(color: colorScheme.onSurface, fontSize: 16), // استخدام اللون المناسب للنصوص
      ),
      onTap: onTap,
    );
  }
}

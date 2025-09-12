import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/home/presentation/manager/theme_Cubit.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF4EDF6), Color(0xF9F4E8EF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: DecorationImage(
            image: AssetImage(kSea), // حط الصورة بتاعتك هنا
            fit: BoxFit.cover,
            opacity: 0.70, // درجة الشفافية عشان النصوص تفضل واضحة
          ),
        ),
        child: Column(
          children: [
            // ----- Header -----
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF745385), Color(0xFF745385)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFC971E4), Color(0xFFC0A7C6)],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Image.asset(kTest, height: 60),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LangKeys.appName.tr(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Smart Management".tr(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // ----- Menu -----
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  _buildDrawerItem(
                    context,
                    icon: Icons.school_outlined,
                    text: LangKeys.school.tr(),
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.kSchoolView),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.child_care,
                    text: LangKeys.children.tr(),
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.kChildrenSchool),
                  ),
                  _buildExpansion(
                    title: LangKeys.mainBills.tr(),
                    items: [
                      _buildDrawerItem(
                        context,
                        icon: Icons.receipt_long,
                        text: LangKeys.allBills.tr(),
                        onTap: () => GoRouter.of(
                          context,
                        ).push(AppRouter.kGetAllBillsView),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.recent_actors,
                        text: LangKeys.allActiveBills.tr(),
                        onTap: () => GoRouter.of(
                          context,
                        ).push(AppRouter.kGetAllActiveBillsView),
                      ),
                    ],
                  ),
                  _buildExpansion(
                    title: LangKeys.coffeeBills.tr(),
                    items: [
                      _buildDrawerItem(
                        context,
                        icon: Icons.coffee,
                        text: LangKeys.allBills.tr(),
                        onTap: () =>
                            GoRouter.of(context).push(AppRouter.kCoffeeBills),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.recent_actors,
                        text: LangKeys.allActiveBills.tr(),
                        onTap: () => GoRouter.of(
                          context,
                        ).push(AppRouter.kActiveCoffeeBills),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildDrawerItem(
                    context,
                    icon: Icons.language,
                    text: LangKeys.changeLanguage.tr(),
                    onTap: () {
                      Locale newLocale = context.locale.languageCode == 'en'
                          ? const Locale('ar', 'EG')
                          : const Locale('en', 'US');
                      context.setLocale(newLocale);
                    },
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
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.kLoginView);
                    },
                  ),
                ],
              ),
            ),

            // ----- Footer -----
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.copyright, size: 12, color: Colors.white54),
                  SizedBox(width: 4),
                  Text(
                    "2025 Monkey App",
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
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
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Color(0xFF510D73), size: 24), // أغمق
      ),
      title: Text(
        text,
        style: GoogleFonts.playfairDisplay( // خط فخم
          color: Color(0xFF510D73),
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildExpansion({required String title, required List<Widget> items}) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedIconColor: Colors.black54,
        iconColor: Colors.amber,
        leading: const Icon(Icons.folder_open, color: Color(0xFF510D73)),
        title: Text(
          title,
          style: GoogleFonts.playfairDisplay(
            color: Color(0xFF510D73),
            fontSize: 18,
            fontWeight: FontWeight.w700,

          ),
        ),
        children: items,
      ),
    );
  }

}

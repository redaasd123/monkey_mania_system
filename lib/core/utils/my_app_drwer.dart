import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/theme_color/theme_Cubit.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: Container(
        color: colorScheme.surface,
        child: Column(
          children: [
            // ----- Header -----
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: colorScheme.onPrimary,
                    child: Image.asset(kTest),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LangKeys.appName.tr(),
                    style: GoogleFonts.montserrat(
                      color: colorScheme.onPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Smart Management".tr(),
                    style: GoogleFonts.montserrat(
                      color: colorScheme.onPrimary.withOpacity(0.7),
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

                  // Schools
                  _buildDrawerItem(
                    context,
                    icon: FontAwesomeIcons.school,
                    text: LangKeys.school.tr(),
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.kSchoolView),
                  ),

                  // Children
                  _buildDrawerItem(
                    context,
                    icon: FontAwesomeIcons.child,
                    text: LangKeys.children.tr(),
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.kChildrenSchool),
                  ),

                  // Main Bills
                  _buildFancyExpansion(
                    context,
                    title: LangKeys.mainBills.tr(),
                    icon: FontAwesomeIcons.receipt,
                    backgroundColor: Colors.blue.shade50,
                    iconColor: Colors.blueAccent,
                    items: [
                      _buildDrawerItem(
                        context,
                        icon: FontAwesomeIcons.list,
                        text: LangKeys.allBills.tr(),
                        onTap: () =>
                            GoRouter.of(context).push(AppRouter.kGetAllBillsView),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: FontAwesomeIcons.checkCircle,
                        text: LangKeys.allActiveBills.tr(),
                        onTap: () => GoRouter.of(context)
                            .push(AppRouter.kGetAllActiveBillsView),
                      ),
                    ],
                  ),

                  // Coffee Bills
                  _buildFancyExpansion(
                    context,
                    title: LangKeys.coffeeBills.tr(),
                    icon: FontAwesomeIcons.coffee,
                    backgroundColor: Colors.brown.shade50,
                    iconColor: Colors.brown,
                    items: [
                      _buildDrawerItem(
                        context,
                        icon: FontAwesomeIcons.list,
                        text: LangKeys.allBills.tr(),
                        onTap: () =>
                            GoRouter.of(context).push(AppRouter.kCoffeeBills),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: FontAwesomeIcons.checkCircle,
                        text: LangKeys.allActiveBills.tr(),
                        onTap: () =>
                            GoRouter.of(context).push(AppRouter.kActiveCoffeeBills),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Language
                  _buildDrawerItem(
                    context,
                    icon: FontAwesomeIcons.language,
                    text: LangKeys.changeLanguage.tr(),
                    onTap: () {
                      Locale newLocale = context.locale.languageCode == 'en'
                          ? const Locale('ar', 'EG')
                          : const Locale('en', 'US');
                      context.setLocale(newLocale);
                    },
                  ),

                  // Night Mode
                  _buildDrawerItem(
                    context,
                    icon: FontAwesomeIcons.moon,
                    text: LangKeys.nightMode.tr(),
                    onTap: () {
                      context.read<ThemeCubit>().toggle();
                      Navigator.pop(context);
                    },
                  ),

                  // Logout
                  _buildDrawerItem(
                    context,
                    icon: FontAwesomeIcons.rightFromBracket,
                    text: LangKeys.logOut.tr(),
                    onTap: () async {
                      await AuthHelper.clearAuthData();
                      await AuthHelper.logOut();
                      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                    },
                  ),
                ],
              ),
            ),

            // ----- Footer -----
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.copyright,
                      size: 12, color: colorScheme.onSurface.withOpacity(0.6)),
                  const SizedBox(width: 4),
                  Text(
                    "2025 Monkey App",
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 12,
                    ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: colorScheme.secondaryContainer,
        child: FaIcon(icon, color: colorScheme.onSecondaryContainer, size: 20),
      ),
      title: Text(
        text,
        style: GoogleFonts.playfairDisplay(
          color: colorScheme.onSurface,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildFancyExpansion(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<Widget> items,
        Color? backgroundColor,
        Color? iconColor,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: backgroundColor ?? colorScheme.surface,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: (backgroundColor ?? colorScheme.secondaryContainer).withOpacity(0.5),
            child: FaIcon(icon, color: iconColor ?? colorScheme.onSecondaryContainer, size: 24),
          ),
          collapsedIconColor: colorScheme.onSurface,
          iconColor: colorScheme.primary,
          title: Text(
            title,
            style: GoogleFonts.playfairDisplay(
              color: colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: items,
        ),
      ),
    );
  }
}

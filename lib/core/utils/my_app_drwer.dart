import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/theme_color/theme_Cubit.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/show_select_branch_with_login.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Column(
        children: [
          // ---------- HEADER ----------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: colorScheme.onPrimary,
                    child: Image.asset(kTest, height: 100),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  LangKeys.appName.tr(),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SecretTapArea()
              ],
            ),
          ),

          // ---------- MENU ----------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  context,
                  title: LangKeys.school.tr(),
                  icon: FontAwesomeIcons.school,
                  color: Colors.teal,
                  onTap: () => GoRouter.of(context).push(AppRouter.kSchoolView),
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.children.tr(),
                  icon: FontAwesomeIcons.child,
                  color: Colors.purple,
                  onTap: () =>
                      GoRouter.of(context).push(AppRouter.kChildrenSchool),
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.mainBills.tr(),
                  icon: FontAwesomeIcons.receipt,
                  color: Colors.blue,
                  popupItems: [
                    {
                      'title': LangKeys.allBills.tr(),
                      'onTap': () =>
                          GoRouter.of(context).push(AppRouter.kGetAllBillsView),
                    },
                    {
                      'title': LangKeys.allActiveBills.tr(),
                      'onTap': () => GoRouter.of(
                        context,
                      ).push(AppRouter.kGetAllActiveBillsView),
                    },
                  ],
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.coffeeBills.tr(),
                  icon: FontAwesomeIcons.coffee,
                  color: Colors.brown,
                  popupItems: [
                    {
                      'title': LangKeys.allBills.tr(),
                      'onTap': () =>
                          GoRouter.of(context).push(AppRouter.kCoffeeBills),
                    },
                    {
                      'title': LangKeys.allActiveBills.tr(),
                      'onTap': () => GoRouter.of(
                        context,
                      ).push(AppRouter.kActiveCoffeeBills),
                    },
                  ],
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.expense.tr(),
                  icon: FontAwesomeIcons.receipt,
                  color: Colors.blue,
                  popupItems: [
                    {
                      'title': LangKeys.material.tr(),
                      'onTap': () => GoRouter.of(
                        context,
                      ).push(AppRouter.kMaterialExpenseView),
                    },
                    {
                      'title': LangKeys.general.tr(),
                      'onTap': () => GoRouter.of(
                        context,
                      ).push(AppRouter.kGeneralExpenseView),
                    },
                  ],
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.users.tr(),
                  icon: FontAwesomeIcons.users,
                  color: Colors.red,
                  onTap: () =>
                      GoRouter.of(context).pushReplacement(AppRouter.kUsers),
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.analytics.tr(),
                  icon: FontAwesomeIcons.android,
                  color: Colors.red,
                  onTap: () =>
                      GoRouter.of(context).pushReplacement(AppRouter.kAnalytic),
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.changeLanguage.tr(),
                  icon: FontAwesomeIcons.language,
                  color: Colors.orange,
                  onTap: () {
                    Locale newLocale = context.locale.languageCode == 'en'
                        ? const Locale('ar', 'EG')
                        : const Locale('en', 'US');
                    context.setLocale(newLocale);
                  },
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.nightMode.tr(),
                  icon: FontAwesomeIcons.moon,
                  color: Colors.indigo,
                  onTap: () {
                    context.read<ThemeCubit>().toggle();
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.selectBranch.tr(),
                  icon: FontAwesomeIcons.codeBranch,
                  color: Colors.green,
                  onTap: () {
                    showSelectBranchWithLoginBottomSheet(
                      context,
                      onSelected: (branchId) {
                        BlocProvider.of<BranchCubit>(
                          context,
                        ).selectBranch(branchId);
                      },
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  title: LangKeys.chatToOwner.tr(),
                  icon: FontAwesomeIcons.chartBar,
                  color: Colors.green,
                  onTap: () async {
                    final role = AuthHelper.getRole();

                    if (role == 'waiter' || role == 'reception') {
                      GoRouter.of(context).push(AppRouter.kChatWithOwner);
                    } else {
                       GoRouter.of(context).push(AppRouter.kOwnerPage);
                    }
                  },
                ),

                _buildDrawerItem(
                  context,
                  title: LangKeys.logOut.tr(),
                  icon: FontAwesomeIcons.rightFromBracket,
                  color: Colors.red,
                  onTap: () async {
                    await AuthHelper.clearAuthData();
                    await AuthHelper.logOut();
                    GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            color: colorScheme.primary.withOpacity(0.05),
            child: Center(
              child: Text(
                "© 2025 Monkey App",
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- DRAWER ITEM ----
  Widget _buildDrawerItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
    List<Map<String, dynamic>>? popupItems,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            radius: 16,
            child: Icon(icon, color: color, size: 18),
          ),
          title: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          trailing: popupItems != null
              ? PopupMenuButton<int>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]!.withOpacity(0.95)
                      : Colors.white.withOpacity(0.95),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings,
                        color: colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, size: 20),
                    ],
                  ),
                  itemBuilder: (context) {
                    return popupItems.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final item = entry.value;
                      return PopupMenuItem<int>(
                        value: idx,
                        child: Row(
                          children: [
                            if (item['icon'] != null)
                              Icon(item['icon'], color: colorScheme.primary),
                            if (item['icon'] != null) const SizedBox(width: 8),
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: item['onTap'],
                      );
                    }).toList();
                  },
                )
              : null,
          onTap: onTap,
        ),
        Divider(
          height: 1,
          color: Theme.of(context).brightness == Brightness.dark
              ? Color(0xFF424242)
              : const Color(0xFFE0E0E0),
        ),
      ],
    );
  }
}

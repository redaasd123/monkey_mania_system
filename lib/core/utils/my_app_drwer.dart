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
      child: Column(
        children: [
          // ---------- HEADER ----------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
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
                  ),
                ),
                Text(
                  "Smart Management".tr(),
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // ---------- MENU ----------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildCardItem(
                  context,
                  title: LangKeys.school.tr(),
                  icon: FontAwesomeIcons.school,
                  color: Colors.teal,
                  onTap: () => GoRouter.of(context).push(AppRouter.kSchoolView),
                ),
                _buildCardItem(
                  context,
                  title: LangKeys.children.tr(),
                  icon: FontAwesomeIcons.child,
                  color: Colors.purple,
                  onTap: () =>
                      GoRouter.of(context).push(AppRouter.kChildrenSchool),
                ),
                _buildCardItem(
                  context,
                  title: LangKeys.mainBills.tr(),
                  icon: FontAwesomeIcons.receipt,
                  color: Colors.blue,
                  onTap: () =>
                      GoRouter.of(context).push(AppRouter.kGetAllBillsView),
                  extraActions: [
                    _buildChipAction(
                      context,
                      text: LangKeys.allBills.tr(),
                      onTap: () =>
                          GoRouter.of(context).push(AppRouter.kGetAllBillsView),
                    ),
                    _buildChipAction(
                      context,
                      text: LangKeys.allActiveBills.tr(),
                      onTap: () => GoRouter.of(
                        context,
                      ).push(AppRouter.kGetAllActiveBillsView),
                    ),
                  ],
                ),
                _buildCardItem(
                  context,
                  title: LangKeys.coffeeBills.tr(),
                  icon: FontAwesomeIcons.coffee,
                  color: Colors.brown,
                  onTap: () =>
                      GoRouter.of(context).push(AppRouter.kCoffeeBills),
                  extraActions: [
                    _buildChipAction(
                      context,
                      text: LangKeys.allBills.tr(),
                      onTap: () =>
                          GoRouter.of(context).push(AppRouter.kCoffeeBills),
                    ),
                    _buildChipAction(
                      context,
                      text: LangKeys.allActiveBills.tr(),
                      onTap: () => GoRouter.of(
                        context,
                      ).push(AppRouter.kActiveCoffeeBills),
                    ),
                  ],
                ),





                _buildCardItem(
                  context,
                  title: 'Expense',
                  icon: FontAwesomeIcons.receipt,
                  color: Colors.blue,
                  onTap: () =>
                      GoRouter.of(context).push(AppRouter.kGeneralExpenseView),
                  extraActions: [
                    _buildChipAction(
                      context,
                      text:'material',
                      onTap: () =>
                          GoRouter.of(context).push(AppRouter.kMaterialExpenseView),
                    ),
                    _buildChipAction(
                      context,
                      text: 'general',
                      onTap: () => GoRouter.of(
                        context,
                      ).push(AppRouter.kGeneralExpenseView),
                    ),
                  ],
                ),





                _buildCardItem(
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

                _buildCardItem(
                  context,
                  title: LangKeys.nightMode.tr(),
                  icon: FontAwesomeIcons.moon,
                  color: Colors.indigo,
                  onTap: () {
                    context.read<ThemeCubit>().toggle();
                    Navigator.pop(context);
                  },
                ),
                _buildCardItem(
                  context,
                  title: "Select Branch",
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
                _buildCardItem(
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

          // ---------- FOOTER ----------
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

  // ---- CARD ITEM ----
  Widget _buildCardItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    List<Widget>? extraActions,
  }) {
    final colorScheme = Theme.of(context).colorScheme; // ⬅️ جبت ألوان الثيم

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      color: colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    child: Icon(icon, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              if (extraActions != null) ...[
                const SizedBox(height: 10),
                Wrap(spacing: 8, children: extraActions),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ---- CHIP ACTION ----
  Widget _buildChipAction(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      label: Text(text, style: const TextStyle(fontSize: 13)),
      backgroundColor: Colors.grey.shade200,
      onPressed: onTap,
      avatar: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}

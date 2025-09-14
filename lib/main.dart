import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/children/domain/param/fetch_children_param.dart';

import 'core/theme_color/color_them.dart';
import 'core/utils/app_router.dart';
import 'core/utils/main_init.dart';
import 'core/utils/service_locator.dart';
import 'feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'feature/bills/coffe_bills/presentation/manager/coffee_bills/order_cubit.dart';
import 'feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';
import 'feature/bills/main_bills/presentation/manager/apply_discount_cubit/apply_discount_cubit.dart';
import 'feature/bills/main_bills/presentation/manager/close_bills_cubit/close_bills_cubit.dart';
import 'feature/bills/main_bills/presentation/manager/get_one_bills_cubit.dart';
import 'feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'feature/branch/presentation/manager/branch_cubit.dart';
import 'feature/children/presentation/manager/cubit/children_cubit.dart';
import 'core/theme_color/theme_Cubit.dart';
import 'feature/school/presintation/manager/school_cubit/school_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await AppInitializer.initializeApp();
  runApp(AppInitializer.buildApp());
}

class MonkeyApp extends StatelessWidget {
  const MonkeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>getIt<OrdersCubit>()),
        BlocProvider(create: (context) => getIt<BillsCubit>()),
        BlocProvider(create: (context) => getIt<CloseBillsCubit>()),
        BlocProvider(create: (context) => getIt<ApplyDiscountCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<ChildrenCubit>()..fetchChildren(FetchChildrenParam()),
        ),
        BlocProvider(create: (context) => getIt<SchoolCubit>()..fetchSchool()),
        BlocProvider(create: (context) => getIt<BranchCubit>()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return Builder(
            builder: (context) {
              final isArabic = context.locale.languageCode == 'ar';

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: mode,
                routerConfig: AppRouter.router,
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,

                builder: (context, child) {
                  return Directionality(
                    textDirection: isArabic
                        ? ui.TextDirection.rtl
                        : ui.TextDirection.ltr,
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

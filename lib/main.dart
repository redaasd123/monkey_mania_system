import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/app_router.dart';
import 'core/utils/main_init.dart';
import 'core/utils/service_locator.dart';
import 'feature/home/presentation/view/widget/manager/theme_Cubit.dart';
import 'feature/school/presintation/manager/post_cubit/post_cubit.dart';
import 'feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'core/theme_color/color_them.dart'; // ✅ الثيمات

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
        BlocProvider(create: (context) => getIt<SchoolCubit>()..fetchSchool()),
        BlocProvider(create: (context) => getIt<PostCubit>()),
        BlocProvider(create: (context) => getIt<UpdateSchoolCubit>()),
        BlocProvider(create: (_) => ThemeCubit()), // ✅ بدون Hive
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            // ✅ اسم صحيح
            darkTheme: AppTheme.darkTheme,
            // ✅ اسم صحيح
            themeMode: mode,
            // ← بياخد القيمة من ThemeCubit
            routerConfig: AppRouter.router,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          );
        },
      ),
    );
  }
}

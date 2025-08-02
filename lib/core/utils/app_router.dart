import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/bills/presentation/view/bills_view.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/view/children_view.dart';
import 'package:monkey_app/feature/children/presentation/view/show_detail_children.dart';
import 'package:monkey_app/feature/login/presentaion/view/login_view.dart';
import 'package:monkey_app/feature/school/presintation/view/school_view.dart';
import 'package:monkey_app/feature/splash/presentation/views/splash_view.dart';

import '../../feature/home/presentation/view/home_view.dart';
import '../../main.dart';

abstract class AppRouter{

  static const kLoginView = '/login';
  static const kSchoolView = '/school';
  static const kHomeView = '/home';
  static const kEditSchool = '/edit-school';
  static const kChildrenSchool = '/children';
  static const kShowDetailChildren = '/kShowDetailChildren';
  static const kBillsView = '/kBillsView';
  static final router = GoRouter(
    navigatorKey: navigatorKey,
      routes: [


        GoRoute(path: '/',
          builder: (context, state) => const SplashView(),),

        GoRoute(path: kBillsView,
          builder: (context, state) => BillsView(),),


        GoRoute(path: kShowDetailChildren,
      builder: (context, state) => ShowDetailChildren(childrenEntity: state.extra as ChildrenEntity,),),

    GoRoute(path: kLoginView,
      builder: (context, state) => const LoginView(),),

    GoRoute(path: kHomeView,
      builder: (context, state) => const HomeView(),),

    GoRoute(path: kSchoolView,
      builder: (context, state) => const SchoolView(),),

    GoRoute(path: kChildrenSchool,
      builder: (context, state) => const ChildrenView(),),

    // GoRoute(path: kEditSchool,
    //   builder: (context, state) =>
    //   EditSchoolView(postModel: state.extra as PostModel,),)


  ]);


}
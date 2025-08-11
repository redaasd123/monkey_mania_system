import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/coffe_bills_view.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/show_detail_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/all_active/all_active_coffee_bills_view.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/view/children_view.dart';
import 'package:monkey_app/feature/children/presentation/view/show_detail_children.dart';
import 'package:monkey_app/feature/login/presentaion/view/login_view.dart';
import 'package:monkey_app/feature/school/presintation/view/school_view.dart';
import 'package:monkey_app/feature/splash/presentation/views/splash_view.dart';

import '../../feature/bills/main_bills/presentation/view/get_all_bills_view.dart';
import '../../feature/bills/main_bills/presentation/view/widget/all_active_bills/all_active_bills_view.dart';
import '../../feature/bills/main_bills/presentation/view/widget/show_detail_bills/show_detail_bills.dart';
import '../../feature/home/presentation/view/home_view.dart';
import '../../main.dart';

abstract class AppRouter {
  static const kLoginView = '/login';
  static const kSchoolView = '/school';
  static const kHomeView = '/home';
  static const kEditSchool = '/edit-school';
  static const kChildrenSchool = '/children';
  static const kShowDetailChildren = '/kShowDetailChildren';
  static const kGetAllBillsView = '/kBillsView';
  static const kShowDetailBills = '/kShowDetailBills';
  static const kGetAllActiveBillsView = '/kGetAllActiveBillsView';
  static const kCoffeeBills = '/kCoffeeBills';
  static const kActiveCoffeeBills = '/kActiveCoffeeBills';
  static const kShowDetailCoffeeBills = '/kShowDetailCoffeeBills';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: kShowDetailCoffeeBills,
        builder: (context, state) =>  ShowDetailCoffee(id:state.extra as int,),
      ),
      GoRoute(
        path: kCoffeeBills,
        builder: (context, state) => const CoffeeBillsView(),
      ),

      GoRoute(
        path: kActiveCoffeeBills,
        builder: (context, state) => const AllActiveCoffeeBillsView(),
      ),

      GoRoute(
        path: kShowDetailBills,
        builder: (context, state) {
          final billId = state.extra as num;
          return ShowDetailBills(id: billId);
        },
      ),

      GoRoute(
        path: kGetAllActiveBillsView,
        builder: (context, state) => const GetAllActiveBillsView(),
      ),

      GoRoute(path: '/', builder: (context, state) => const SplashView()),

      GoRoute(path: kGetAllBillsView, builder: (context, state) => BillsView()),

      GoRoute(
        path: kShowDetailChildren,
        builder: (context, state) =>
            ShowDetailChildren(childrenEntity: state.extra as ChildrenEntity),
      ),

      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),

      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),

      GoRoute(
        path: kSchoolView,
        builder: (context, state) => const SchoolView(),
      ),

      GoRoute(
        path: kChildrenSchool,
        builder: (context, state) => const ChildrenView(),
      ),

      // GoRoute(path: kEditSchool,
      //   builder: (context, state) =>
      //   EditSchoolView(postModel: state.extra as PostModel,),)
    ],
  );
}

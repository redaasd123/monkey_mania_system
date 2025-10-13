import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/coffe_bills_view.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/show_detail_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/all_active/all_active_coffee_bills_view.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/create_bills/create_bills_view.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/view/children_view.dart';
import 'package:monkey_app/feature/children/presentation/view/show_detail_children.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/manager/anlytic_cubit.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/view/analytic_view.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/manager/general_expense_cubit.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/manager/material_expense_cubit.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/view/material_expense_view.dart';
import 'package:monkey_app/feature/login/presentaion/view/login_view.dart';
import 'package:monkey_app/feature/school/presintation/view/school_view.dart';
import 'package:monkey_app/feature/splash/presentation/views/splash_view.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';
import 'package:monkey_app/feature/users/presentation/view/user_view.dart';

import '../../feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import '../../feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';
import '../../feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../feature/bills/main_bills/presentation/manager/get_one_bills_cubit.dart';
import '../../feature/bills/main_bills/presentation/view/get_all_bills_view.dart';
import '../../feature/bills/main_bills/presentation/view/widget/all_active_bills/all_active_bills_view.dart';
import '../../feature/bills/main_bills/presentation/view/widget/show_detail_bills/show_detail_bills.dart';
import '../../feature/expense/general_expense/presentation/view/general_expense_view.dart';
import '../../feature/home/presentation/view/home_view.dart';
import '../../main.dart';

abstract class AppRouter {
  static const kUsers = '/kUsers';
  static const kAnalytic = '/kAnalytic';
  static const kGeneralExpenseView = '/kGeneralExpenseView';
  static const kMaterialExpenseView = '/kMaterialExpenseView';
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
  static const kCreateCoffeeBillsView = '/kCreateCoffeeBillsView';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: kUsers,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                getIt<UserCubit>()..fetchUsers(RequestParameters()),
            child: UserView(),
          );
        },
      ),

      GoRoute(
        path: kShowDetailCoffeeBills,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<GetOneBillsCoffeeCubit>(),
            child: ShowDetailCoffee(id: state.extra as int),
          );
        },
      ),

      GoRoute(
        path: kShowDetailBills,
        builder: (context, state) {
          final billId = state.extra as num;
          return BlocProvider(
            create: (context) => getIt<GetOneBillsCubit>(),
            child: ShowDetailBills(id: billId),
          );
        },
      ),

      GoRoute(
        path: kCoffeeBills,
        builder: (context, state) => const CoffeeBillsView(),
      ),
      GoRoute(
        path: kCreateCoffeeBillsView,
        builder: (context, state) {
          final branch = AuthHelper.getBranch();
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<CoffeeBillsCubit>()),
              BlocProvider(
                create: (context) =>
                    getIt<LayersCubit>()
                      ..getLayerOne(RequestParameters(branch: [branch])),
              ),
            ],

            child: const CreateBillsView(),
          );
        },
      ),

      GoRoute(
        path: kActiveCoffeeBills,
        builder: (context, state) => const AllActiveCoffeeBillsView(),
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

      GoRoute(
        path: kGeneralExpenseView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                getIt<GeneralExpenseCubit>()
                  ..fetchAllGeneralExpense(RequestParameters(branch: ['all'])),
            child: const GeneralExpenseView(),
          );
        },
      ),

      GoRoute(
        path: kAnalytic,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<AnalyticCubit>()..fetchAnalyticType(),
            child: const AnalyticView(),
          );
        },
      ),

      GoRoute(
        path: kMaterialExpenseView,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<MaterialExpenseCubit>()
                  ..fetchAllMaterialExpense(RequestParameters(branch: ['all'])),
              ),
            ],
            child: const MaterialExpenseView(),
          );
        },
      ),
    ],
  );
}

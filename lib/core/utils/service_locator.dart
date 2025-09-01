import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/contivity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffee_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/repos/bills_coffee_impl.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/create_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_active_bills_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_one_coffee_bills_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/data/data_source/bills_remote_data_source.dart';
import 'package:monkey_app/feature/bills/main_bills/data/repos/bills_repo_impl.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/repo/bills_repo.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/apply_discount_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/close_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/create_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/fetch_active_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/fetch_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/get_one_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/apply_discount_cubit/apply_discount_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/close_bills_cubit/close_bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/get_one_bills_cubit.dart';
import 'package:monkey_app/feature/branch/data/data_source/branch_remote_data_source.dart';
import 'package:monkey_app/feature/branch/data/repos/branch_repos_impl.dart';
import 'package:monkey_app/feature/branch/domain/repo/branch_repo.dart';
import 'package:monkey_app/feature/branch/domain/use_case/branch_use_case.dart';
import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';
import 'package:monkey_app/feature/children/data/data_source/childern_local_data_source.dart';
import 'package:monkey_app/feature/children/data/data_source/children_remote_data_source.dart';
import 'package:monkey_app/feature/children/data/repos/children_repo_impl.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/create_chil_use_case.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/fetch_children_use_case.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/update_children_use_case.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
/* ───────── Features Imports ───────── */
import 'package:monkey_app/feature/login/data/data_source/login_remote_data_source.dart';
import 'package:monkey_app/feature/login/data/repos/login_repo_impl.dart';
import 'package:monkey_app/feature/login/domain/repo/login_repo.dart';
import 'package:monkey_app/feature/login/domain/use_case/login_repo_use_case.dart';
import 'package:monkey_app/feature/login/presentaion/manager/login_cubit/login_cubit.dart';
import 'package:monkey_app/feature/school/data/data_source/school_local_data_source.dart';
import 'package:monkey_app/feature/school/data/data_source/school_remote_data_source.dart';
import 'package:monkey_app/feature/school/data/repos/school_repo_impl.dart';
import 'package:monkey_app/feature/school/domain/repo/school_repo.dart';
import 'package:monkey_app/feature/school/domain/use_case/fetch_school_use_case.dart';
import 'package:monkey_app/feature/school/domain/use_case/post_school_use_case.dart';
import 'package:monkey_app/feature/school/domain/use_case/update_school_use_case.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  /* ───────── Core ───────── */
  final dio = Dio();
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<Api>(() => Api(dio: getIt()));
  getIt.registerLazySingleton(() => ConnectivityService());

  /* ───────── Login Layer ───────── */
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(getIt<Api>()),
  );
  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(loginRemoteDataSource: getIt()),
  );
  getIt.registerFactory(() => LoginRepoUseCase(loginRepo: getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));

  /* ───────── School Layer ───────── */
  getIt.registerLazySingleton<SchoolRemoteDataSource>(
    () => SchoolRemoteDataSourceImpl(api: getIt()),
  );
  getIt.registerLazySingleton<SchoolLocalDataSource>(
    () => SchoolLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<SchoolRepo>(
    () => SchoolRepoImpl(getIt(), schoolRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => FetchSchoolUseCase(schoolRpo: getIt()));
  getIt.registerLazySingleton(() => UpdateSchoolUseCase(schoolRpo: getIt()));
  getIt.registerLazySingleton(() => PostSchoolUseCase(schoolRepo: getIt()));
  getIt.registerFactory(() => SchoolCubit(getIt(), getIt(), getIt()));

  /* ───────── Children Layer ───────── */
  getIt.registerLazySingleton<ChildrenRemoteDataSource>(
    () => ChildrenRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ChildrenLocalDataSource>(
    () => ChildrenLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<ChildrenRepo>(
    () => ChildrenRepoImpl(getIt(), childrenRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchChildrenUseCase(childrenRepo: getIt()),
  );
  getIt.registerLazySingleton(() => CreateChildUseCase(childrenRepo: getIt()));
  getIt.registerLazySingleton(
    () => UpdateChildrenUseCase(childrenRepo: getIt()),
  );
  getIt.registerFactory(
    () => ChildrenCubit(
      fetchChildrenUseCase: getIt(),
      createChildUseCase: getIt(),
      updateChildrenUseCase: getIt(),
    ),
  );

  /* ───────── Branch Layer ───────── */
  getIt.registerLazySingleton<BranchRemoteDataSource>(
    () => BranchRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<BranchRepo>(
    () => BranchRepoImpl(branchRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => BranchUseCase(branchRepo: getIt()));
  getIt.registerFactory(() => BranchCubit(getIt()));

  /* ───────── Main Bills Layer ───────── */
  getIt.registerLazySingleton<BillsRemoteDataSource>(
    () => BillsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<BillsRepo>(
    () => BillsRepoImpl(billsRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => BillsUseCase(billsRepo: getIt()));
  getIt.registerLazySingleton(() => CreateBillsUseCase(billsRepo: getIt()));
  getIt.registerLazySingleton(() => ApplyDiscountUseCase(billsRepo: getIt()));
  getIt.registerLazySingleton(
    () => FetchActiveBillsUseCase(billsRepo: getIt()),
  );
  getIt.registerLazySingleton(() => CloseBillsUseCase(billsRepo: getIt()));
  getIt.registerLazySingleton(() => GetOneBillUseCase(billsRepo: getIt()));
  getIt.registerFactory(
    () => BillsCubit(getIt(), getIt(), getIt(), getIt.get()),
  );
  getIt.registerFactory(() => ApplyDiscountCubit(getIt()));
  getIt.registerFactory(() => CloseBillsCubit(getIt()));
  getIt.registerFactory(() => GetOneBillsCubit(getIt()));

  /* ───────── Coffee Bills Layer ───────── */
  getIt.registerLazySingleton<BillsCoffeeDataSource>(
    () => BillsCoffeeDataSourceImpl(),
  );
  getIt.registerLazySingleton<CoffeeBillsRepo>(
    () => BillsCoffeeImpl(billsCoffeeDataSource: getIt()),
  );
  getIt.registerLazySingleton(
    () => CreateBillsCoffeeUSeCase(billsRepo: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetOneCoffeeBillsUseCase(coffeeBillsRepo: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchBillsCoffeeUSeCase(coffeeBillsRepo: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchActiveBillsCoffeeUSeCase(coffeeBillsRepo: getIt()),
  );
  getIt.registerFactory(
    () => CoffeeBillsCubit(getIt(), getIt(), getIt(), getIt()),
  );
}

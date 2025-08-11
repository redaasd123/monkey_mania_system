import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffee_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/repos/bills_coffee_impl.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_one_coffee_bills_use_case.dart';
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
import 'package:monkey_app/feature/children/presentation/manager/cubit/create_child_cubit.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/update_children_cubit.dart';
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
import 'package:monkey_app/feature/school/presintation/manager/post_cubit/post_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

import '../../feature/bills/coffe_bills/domain/use_case/fetch_active_bills_coffee.dart';
import '../../feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import '../../feature/bills/main_bills/data/data_source/bills_remote_data_source.dart';
import '../../feature/bills/main_bills/data/repos/bills_repo_impl.dart';
import '../../feature/bills/main_bills/domain/repo/bills_repo.dart';
import '../../feature/bills/main_bills/domain/use_case/apply_discount_use_case.dart';
import '../../feature/bills/main_bills/domain/use_case/close_bills_use_case.dart';
import '../../feature/bills/main_bills/domain/use_case/create_bills_use_case.dart';
import '../../feature/bills/main_bills/domain/use_case/fetch_active_bills_use_case.dart';
import '../../feature/bills/main_bills/domain/use_case/fetch_bills_use_case.dart';
import '../../feature/bills/main_bills/domain/use_case/get_one_bills_use_case.dart';
import '../../feature/bills/main_bills/presentation/manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../feature/bills/main_bills/presentation/manager/close_bills_cubit/close_bills_cubit.dart';
import '../../feature/bills/main_bills/presentation/manager/create_bills_cubit/create_bills_cubit.dart';
import '../../feature/bills/main_bills/presentation/manager/ferch_activ_bills/fetch_active_bills_cubit.dart';
import '../../feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import '../../feature/bills/main_bills/presentation/manager/get_one_bills_cubit.dart';
import '../../feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'contivity.dart';

// ← تأكد من وجوده

final getIt = GetIt.instance;

void setUpServiceLocator() {
  final dio = Dio();

  // 2️⃣ فعّل الـ Interceptors عليها
  // setupInterceptors(dio); // ✅ مهم جداً

  /// 3️⃣ سجلها في GetIt
  getIt.registerLazySingleton<Dio>(() => dio);

  // 4️⃣ سجل الـ Api بعدين باستخدام نفس Dio اللي عليه Interceptor
  getIt.registerLazySingleton<Api>(() => Api(dio: getIt<Dio>()));

  /* ───────── Login Layer ───────── */
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(getIt<Api>()),
  );

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(loginRemoteDataSource: getIt()),
  );

  getIt.registerFactory<LoginRepoUseCase>(
    () => LoginRepoUseCase(loginRepo: getIt()),
  );

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginRepoUseCase>()),
  );

  /* ───────── School Layer ───────── */

  getIt.registerLazySingleton<SchoolRepo>(
    () => SchoolRepoImpl(getIt.get(), schoolRemoteDataSource: getIt.get()),
  );

  getIt.registerLazySingleton<SchoolLocalDataSource>(
    () => SchoolLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<FetchSchoolUseCase>(
    () => FetchSchoolUseCase(schoolRpo: getIt()),
  );

  getIt.registerLazySingleton<UpdateSchoolUseCase>(
    () => UpdateSchoolUseCase(schoolRpo: getIt()),
  );
  getIt.registerLazySingleton<PostSchoolUseCase>(
    () => PostSchoolUseCase(schoolRepo: getIt.get()),
  );

  getIt.registerLazySingleton<SchoolRemoteDataSource>(
    () => SchoolRemoteDataSourceImpl(api: getIt.get()),
  );
  getIt.registerLazySingleton<SchoolCubit>(
    () => SchoolCubit(getIt<FetchSchoolUseCase>()),
  );
  getIt.registerLazySingleton<CreateSchoolCubit>(
    () => CreateSchoolCubit(getIt<PostSchoolUseCase>()),
  );
  getIt.registerLazySingleton<UpdateSchoolCubit>(
    () => UpdateSchoolCubit(updateSchoolUseCase: getIt.get()),
  );

  /* ───────── children Layer ───────── */
  getIt.registerLazySingleton<ChildrenRepo>(
    () => ChildrenRepoImpl(getIt.get(), childrenRemoteDataSource: getIt.get()),
  );

  getIt.registerLazySingleton<ChildrenLocalDataSource>(
    () => ChildrenLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<FetchChildrenUseCase>(
    () => FetchChildrenUseCase(childrenRepo: getIt.get()),
  );

  getIt.registerLazySingleton<ChildrenRemoteDataSource>(
    () => ChildrenRemoteDataSourceImpl(),
  );
  getIt.registerFactory<ChildrenCubit>(
    () => ChildrenCubit(getIt<FetchChildrenUseCase>()),
  );

  getIt.registerLazySingleton<CreateChildUseCase>(
    () => CreateChildUseCase(childrenRepo: getIt.get()),
  );
  getIt.registerFactory<CreateChildCubit>(
    () => CreateChildCubit(getIt<CreateChildUseCase>()),
  );
  getIt.registerLazySingleton<UpdateChildrenUseCase>(
    () => UpdateChildrenUseCase(childrenRepo: getIt.get()),
  );
  getIt.registerFactory<UpdateChildrenCubit>(
    () => UpdateChildrenCubit(
      updateChildrenUseCase: getIt<UpdateChildrenUseCase>(),
    ),
  );
  getIt.registerLazySingleton<BranchRepo>(
    () => BranchRepoImpl(branchRemoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton<BranchUseCase>(
    () => BranchUseCase(branchRepo: getIt.get()),
  );
  getIt.registerLazySingleton<BranchRemoteDataSource>(
    () => BranchRemoteDataSourceImpl(),
  );

  getIt.registerFactory<BranchCubit>(() => BranchCubit(getIt.get()));
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  getIt.registerLazySingleton<BillsRemoteDataSource>(
    () => BillsRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<BillsRepo>(
    () => BillsRepoImpl(billsRemoteDataSource: getIt.get()),
  );

  getIt.registerLazySingleton<BillsUseCase>(
    () => BillsUseCase(billsRepo: getIt.get()),
  );

  getIt.registerFactory<BillsCubit>(() => BillsCubit(getIt<BillsUseCase>()));
  getIt.registerLazySingleton<CreateBillsUseCase>(
    () => CreateBillsUseCase(billsRepo: getIt.get()),
  );
  getIt.registerFactory<CreateBillsCubit>(() => CreateBillsCubit(getIt.get()));
  getIt.registerLazySingleton<ApplyDiscountUseCase>(
    () => ApplyDiscountUseCase(billsRepo: getIt.get()),
  );
  getIt.registerLazySingleton<ApplyDiscountCubit>(
    () => ApplyDiscountCubit(getIt.get()),
  );
  getIt.registerLazySingleton<FetchActiveBillsUseCase>(
    () => FetchActiveBillsUseCase(billsRepo: getIt.get()),
  );
  getIt.registerFactory<FetchActiveBillsCubit>(
    () => FetchActiveBillsCubit(getIt.get()),
  );

  getIt.registerLazySingleton<CloseBillsUseCase>(
    () => CloseBillsUseCase(billsRepo: getIt.get()),
  );
  getIt.registerFactory<CloseBillsCubit>(() => CloseBillsCubit(getIt.get()));

  getIt.registerLazySingleton<GetOneBillUseCase>(
    () => GetOneBillUseCase(billsRepo: getIt.get()),
  );
  getIt.registerFactory<GetOneBillsCubit>(() => GetOneBillsCubit(getIt.get()));

  getIt.registerFactory<CoffeeBillsRepo>(
    () => BillsCoffeeImpl(billsCoffeeDataSource: getIt.get()),
  );
  getIt.registerLazySingleton<BillsCoffeeDataSource>(
    () => BillsCoffeeDataSourceImpl(),
  );
  getIt.registerFactory<CoffeeBillsCubit>(
    () => CoffeeBillsCubit(getIt.get(), getIt.get(),getIt.get()),
  );
  getIt.registerLazySingleton<GetOneCoffeeBillsUseCase>(
    () => GetOneCoffeeBillsUseCase(coffeeBillsRepo: getIt.get()),
  );
  getIt.registerLazySingleton<FetchBillsCoffeeUSeCase>(
    () => FetchBillsCoffeeUSeCase(coffeeBillsRepo: getIt.get()),
  );

  getIt.registerLazySingleton<FetchActiveBillsCoffeeUSeCase>(
    () => FetchActiveBillsCoffeeUSeCase(coffeeBillsRepo: getIt.get()),
  );
}

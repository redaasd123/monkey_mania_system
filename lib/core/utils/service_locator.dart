import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/feature/bills/data/data_source/bills_remote_data_source.dart';
import 'package:monkey_app/feature/bills/data/repos/bills_repo_impl.dart';
import 'package:monkey_app/feature/bills/domain/repo/bills_repo.dart';
import 'package:monkey_app/feature/bills/domain/use_case/bills_use_case.dart';
import 'package:monkey_app/feature/bills/presentation/manager/bills_cubit.dart';
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

import '../../feature/school/presintation/manager/put_cubit/put_cubit.dart';
import '../helper/intrecptor_helper.dart';
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

  getIt.registerLazySingleton<BillsUseCase>(()=>BillsUseCase(billsRepo: getIt.get()));
  getIt.registerLazySingleton<BillsRemoteDataSource>(()=>BillsRemoteDataSourceImpl());
  getIt.registerFactory<BillsCubit>(()=>BillsCubit(getIt<BillsUseCase>()));
  getIt.registerLazySingleton<BillsRepo>(()=>BillsRepoImpl(billsRemoteDataSource: getIt.get()));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/contivity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffe_local_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffee_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/repos/bills_coffee_impl.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/create_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_active_bills_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_all_layers_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_layer_one.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_layer_tow.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_one_coffee_bills_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/return_products_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/order_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/data/data_source/bills_remote_data_source.dart';
import 'package:monkey_app/feature/bills/main_bills/data/repos/bills_repo_impl.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/repo/bills_repo.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/apply_discount_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/close_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/create_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/fetch_active_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/fetch_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/get_one_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/update_calcoulation_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/apply_discount_cubit/apply_discount_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/close_bills_cubit/close_bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/get_one_bills_cubit.dart';
import 'package:monkey_app/feature/branch/data/data_source/branch_remote_data_source.dart';
import 'package:monkey_app/feature/branch/data/repos/branch_repos_impl.dart';
import 'package:monkey_app/feature/branch/domain/repo/branch_repo.dart';
import 'package:monkey_app/feature/branch/domain/use_case/branch_use_case.dart';
import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';
import 'package:monkey_app/feature/chat/data/data_source/remote_data_source.dart';
import 'package:monkey_app/feature/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:monkey_app/feature/chat/domain/repo/chat_repo.dart';
import 'package:monkey_app/feature/chat/domain/use_case/send_message_use_case.dart';
import 'package:monkey_app/feature/chat/presentation/manager/chat_cubit.dart';
import 'package:monkey_app/feature/children/data/data_source/childern_local_data_source.dart';
import 'package:monkey_app/feature/children/data/data_source/children_remote_data_source.dart';
import 'package:monkey_app/feature/children/data/repos/children_repo_impl.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/create_chil_use_case.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/fetch_children_use_case.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/non_active.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/update_children_use_case.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import 'package:monkey_app/feature/csv_analytics/data/impl/analytic_impl.dart';
import 'package:monkey_app/feature/csv_analytics/domain/repo/analytic_repo.dart';
import 'package:monkey_app/feature/csv_analytics/domain/use_case/analytic_use_case.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/manager/anlytic_cubit.dart';
import 'package:monkey_app/feature/expense/general_expense/data/data_source/general_expense_remote_data_source.dart';
import 'package:monkey_app/feature/expense/general_expense/data/repo_impl/general_expense_impl.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/create_general_expense_use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/general_expense_use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/update_general_expense_use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/manager/general_expense_cubit.dart';
import 'package:monkey_app/feature/expense/material_expense/data/data_source/general_expense_remote_data_source.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/repo/material_repo.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/create_material_expense_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/material_expense_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/materials_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/update_material_expense_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/manager/material_expense_cubit.dart';
import 'package:monkey_app/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:monkey_app/feature/home/data/repo/home_impl.dart';
import 'package:monkey_app/feature/home/domain/repo/home_repo.dart';
import 'package:monkey_app/feature/home/domain/use_case/home_use_case.dart';
import 'package:monkey_app/feature/home/presentation/manager/home_cubit.dart';
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
import 'package:monkey_app/feature/users/data/data_source/user_data_source.dart';
import 'package:monkey_app/feature/users/data/impl/users_impl.dart';
import 'package:monkey_app/feature/users/domain/repo/users_repo.dart';
import 'package:monkey_app/feature/users/domain/use_case/create_user_use_case.dart';
import 'package:monkey_app/feature/users/domain/use_case/fetch_user_use_case.dart';
import 'package:monkey_app/feature/users/domain/use_case/update_user_use_case.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';

import '../../feature/chat/domain/use_case/get_message_use_case.dart';
import '../../feature/expense/material_expense/data/repo_impl/material_repo_impl.dart';

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
  getIt.registerLazySingleton<ChildrenNonActiveUseCase>(
        () => ChildrenNonActiveUseCase(childrenRepo: getIt.get()),
  );
  getIt.registerLazySingleton(() => CreateChildUseCase(childrenRepo: getIt()));
  getIt.registerLazySingleton(
        () => UpdateChildrenUseCase(childrenRepo: getIt()),
  );
  getIt.registerFactory(
        () =>
        ChildrenCubit(
          childrenNonActiveUseCase: getIt.get(),
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
  getIt.registerLazySingleton(
        () => UpdateCalculationsUseCase(billsRepo: getIt()),
  );
  getIt.registerFactory(
        () => BillsCubit(getIt(), getIt(), getIt(), getIt.get(), getIt.get()),
  );
  getIt.registerFactory(() => ApplyDiscountCubit(getIt()));
  getIt.registerFactory(() => CloseBillsCubit(getIt()));
  getIt.registerFactory(() => GetOneBillsCubit(getIt()));

  /* ───────── Coffee Bills Layer ───────── */
  getIt.registerLazySingleton<BillsCoffeeDataSource>(
        () => BillsCoffeeDataSourceImpl(),
  );
  getIt.registerLazySingleton<BillsCoffeeLocalDataSource>(() =>
      BillsCoffeeLocalDataSourceImpl());
  getIt.registerLazySingleton<CoffeeBillsRepo>(
        () =>
        BillsCoffeeImpl(billsCoffeeDataSource: getIt(),
            billsCoffeeLocalDataSource: getIt.get()),
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
  getIt.registerLazySingleton<ReturnProductsUseCase>(
        () => ReturnProductsUseCase(coffeeBillsRepo: getIt.get()),
  );
  getIt.registerLazySingleton(
        () => FetchActiveBillsCoffeeUSeCase(coffeeBillsRepo: getIt()),
  );
  getIt.registerLazySingleton<GetLayerOneUseCase>(
        () => GetLayerOneUseCase(billsRepo: getIt.get()),
  );
  getIt.registerLazySingleton<GetLayerTowUseCase>(
        () => GetLayerTowUseCase(billsRepo: getIt.get()),
  );
  getIt.registerFactory(
        () => CoffeeBillsCubit(getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<GetAllLayersUseCase>(
        () => GetAllLayersUseCase(coffeeBillsRepo: getIt.get()),
  );
  getIt.registerFactory(() => LayersCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => GetOneBillsCoffeeCubit(getIt()));
  getIt.registerLazySingleton<OrdersCubit>(() => OrdersCubit());
  getIt.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<HomeRepo>(
        () => HomeRepoImpl(homeRemoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton<HomeUseCase>(
        () => HomeUseCase(homeRepo: getIt.get()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt.get()));
  getIt.registerLazySingleton<GeneralExpenseRepo>(
        () => GeneralExpenseImpl(remoteDataSource: getIt.get()),
  );
  getIt.registerCachedFactory<GeneralExpenseRemoteDataSource>(
        () => GeneralExpenseRemoteDataSourceImpl(),
  );
  getIt.registerCachedFactory<CreateGeneralExpenseUseCase>(
        () => CreateGeneralExpenseUseCase(generalExpenseRepo: getIt.get()),
  );
  getIt.registerCachedFactory<UpdateGeneralExpenseUseCase>(
        () => UpdateGeneralExpenseUseCase(generalExpenseRepo: getIt.get()),
  );
  getIt.registerFactory<GeneralExpenseCubit>(
        () =>
        GeneralExpenseCubit(
          updateGeneralExpenseUseCase: getIt.get(),
          generalExpenseUseCase: getIt.get(),
          createGeneralExpenseUseCase: getIt.get(),
        ),
  );

  getIt.registerLazySingleton<GeneralExpenseUseCase>(
        () => GeneralExpenseUseCase(generalExpenseRepo: getIt.get()),
  );

  getIt.registerLazySingleton<MaterialExpenseRepo>(
        () => MaterialExpenseImpl(remoteDataSource: getIt.get()),
  );
  getIt.registerCachedFactory<MaterialExpenseRemoteDataSource>(
        () => MaterialExpenseRemoteDataSourceImpl(),
  );
  getIt.registerCachedFactory<CreateMaterialExpenseUseCase>(
        () => CreateMaterialExpenseUseCase(materialExpenseRepo: getIt.get()),
  );
  getIt.registerCachedFactory<UpdateMaterialExpenseUseCase>(
        () => UpdateMaterialExpenseUseCase(materialExpenseRepo: getIt.get()),
  );
  getIt.registerCachedFactory<MaterialsUseCase>(
        () => MaterialsUseCase(repo: getIt.get()),
  );
  getIt.registerFactory<MaterialExpenseCubit>(
        () =>
        MaterialExpenseCubit(
          materialsUseCase: getIt.get(),
          updateMaterialExpenseUseCase: getIt.get(),
          materialExpenseUseCase: getIt.get(),
          createMaterialExpenseUseCase: getIt.get(),
        ),
  );

  getIt.registerLazySingleton<MaterialExpenseUseCase>(
        () => MaterialExpenseUseCase(materialExpenseRepo: getIt.get()),
  );

  getIt.registerLazySingleton<AnalyticCubit>(() => AnalyticCubit(getIt.get()));
  getIt.registerLazySingleton<AnalyticTypeUseCase>(
        () => AnalyticTypeUseCase(repo: getIt.get()),
  );
  getIt.registerLazySingleton<AnalyticRepo>(() => AnalyticTypeImpl());

  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserDataSourceImpl());
  getIt.registerLazySingleton<UsersRepo>(
        () => UsersRepoImpl(userRemoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton<FetchUserUseCase>(
        () => FetchUserUseCase(usersRepo: getIt.get()),
  );
  getIt.registerLazySingleton<CreateUserUseCase>(
        () => CreateUserUseCase(usersRepo: getIt.get()),
  );
  getIt.registerLazySingleton<UpdateUserUseCase>(
        () => UpdateUserUseCase(usersRepo: getIt.get()),
  );
  getIt.registerLazySingleton<UserCubit>(
        () => UserCubit(getIt.get(), getIt.get(), getIt.get()),
  );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 2️⃣ Remote DataSource
  final ChatRemoteDataSource remoteDataSource = ChatRemoteDataSourceImpl(firestore);
  getIt.registerLazySingleton<ChatRemoteDataSource>(() => remoteDataSource);

  // 3️⃣ Repository
  final ChatRepo repo = ChatRepoImpl(remoteDataSource);
  getIt.registerLazySingleton<ChatRepo>(() => repo);

  // 4️⃣ UseCases
  final SendMessageUseCase sendMessageUseCase = SendMessageUseCase(repo: repo);
  final GetMessageUseCase getMessageUseCase = GetMessageUseCase(repo: repo);
  getIt.registerLazySingleton<SendMessageUseCase>(() => sendMessageUseCase);
  getIt.registerLazySingleton<GetMessageUseCase>(() => getMessageUseCase);

  // 5️⃣ Cubit
  getIt.registerLazySingleton<ChatCubit>(() => ChatCubit(
      sendMessageUseCase: sendMessageUseCase,
      getMessageUseCase: getMessageUseCase));
}

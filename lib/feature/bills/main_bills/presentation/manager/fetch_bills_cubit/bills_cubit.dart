import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/close_bills_use_case.dart';

import '../../../domain/entity/Bills_entity.dart';
import '../../../domain/use_case/apply_discount_use_case.dart';
import '../../../domain/use_case/create_bills_use_case.dart';
import '../../../domain/use_case/fetch_active_bills_use_case.dart';
import '../../../domain/use_case/fetch_bills_use_case.dart';
import '../../../domain/use_case/get_one_bills_use_case.dart';
import '../../view/widget/apply_discount_param.dart';
import '../../view/widget/param/close_bills_param.dart';
import '../../view/widget/param/create_bills_param.dart';
import '../../view/widget/param/fetch_bills_param.dart';

part 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  final CreateBillsUseCase createBillsUseCase;
  final FetchActiveBillsUseCase fetchActiveBillsUseCase;
  final BillsUseCase billsUseCase;
  final GetOneBillUseCase getOneBillUseCase;


  BillsCubit(
    this.createBillsUseCase,
    this.fetchActiveBillsUseCase,
    this.billsUseCase,
    this.getOneBillUseCase,

  ) : super(BillsInitial());

  // 🔹 المتغيرات المشتركة
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  bool isSearching = false;
  String searchQuery = '';
  List<BillsEntity> allBills = [];

  // 🔹 إنشاء فاتورة

  // 🔹 جلب فواتير Active
  Future<void> fetchActiveBills(FetchBillsParam param) async {
    if (isLoading) return;
    isLoading = true;
    emit(FetchActiveBillsLoadingState());
    final result = await fetchActiveBillsUseCase.call(param);
    result.fold(
      (failure) {
        isLoading = false;
        emit(FetchActiveBillsFailureState(errMessage: failure.errMessage));
      },
      (bills) {
        isLoading = false;
        if (bills.isEmpty) {
          allBills.clear();
          emit(BillsEmptyState());
          return;
        }
        allBills = bills;
        emit(FetchActiveBillsSuccessState(bills: bills));
      },
    );
  }

  // 🔹 جلب الفواتير مع Pagination
  Future<void> fetchBills(FetchBillsParam param) async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    final page = currentPage;

    if (page == 1) emit(BillsLoadingState());

    final result = await billsUseCase.call(param);
    result.fold(
      (failure) {
        isLoading = false;
        emit(BillsFailureState(errMessage: failure.errMessage));
      },
      (billsPage) {
        isLoading = false;
        if (billsPage.bills.isEmpty && page == 1) {
          emit(BillsEmptyState());
          return;
        }

        if (page == 1) allBills.clear();
        allBills.addAll(billsPage.bills);

        hasMore = billsPage.nextPage != null;
        if (hasMore) currentPage = page + 1;

        emit(BillsSuccessState(bills: List.from(allBills)));
      },
    );
  }

  Future<void> createBills(CreateBillsParam param) async {
    emit(CreateBillsLoadingState());
    final result = await createBillsUseCase.call(param);
    result.fold((failure) {
      print("🔥 EMIT CreateBillsFailureState: ${failure.errMessage}");

      emit(
        CreateBillsFailureState(
          errMessage: failure.errMessage,
          bills: allBills,
        ),
      );
    }, (_) => emit(CreateBillsSuccessState()));
  }


  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      searchQuery = '';
      currentPage = 1;
      hasMore = true;
      fetchBills(FetchBillsParam(page: 1));
    }
  }

  void searchBills(String query) {
    searchQuery = query;
    currentPage = 1;
    hasMore = true;
    fetchBills(FetchBillsParam(query: query, page: 1));
  }
}

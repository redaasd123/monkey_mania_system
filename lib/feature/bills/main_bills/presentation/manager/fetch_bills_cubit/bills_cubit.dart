import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/Bills_entity.dart';
import '../../../domain/use_case/create_bills_use_case.dart';
import '../../../domain/use_case/fetch_active_bills_use_case.dart';
import '../../../domain/use_case/fetch_bills_use_case.dart';
import '../../../domain/use_case/get_one_bills_use_case.dart';
import '../../view/widget/param/create_bills_param.dart';
import '../../view/widget/param/fetch_bills_param.dart';

part 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  final CreateBillsUseCase createBillsUseCase;
  final FetchActiveBillsUseCase fetchActiveBillsUseCase;
  final BillsUseCase billsUseCase;
  final GetOneBillUseCase getOneBillUseCase;

  BillsCubit(this.createBillsUseCase,
      this.fetchActiveBillsUseCase,
      this.billsUseCase,
      this.getOneBillUseCase,) : super(BillsState());

  // 🔹 إنشاء فاتورة

  // 🔹 جلب فواتير Active
  Future<void> fetchActiveBills(FetchBillsParam param) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, status: BillsStatus.activeLoading));

    final result = await fetchActiveBillsUseCase.call(param);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: BillsStatus.activeFailure,
            errorMessage: failure.errMessage,
          ),
        );
      },
          (bills) {
        if (bills.isEmpty) {
          emit(state.copyWith(isLoading: false, status: BillsStatus.empty));
          return;
        }

        emit(
          state.copyWith(
            bills: bills, // هنا استبدلت الداتا كلها
            status: BillsStatus.activeSuccess,
            isLoading: false,
          ),
        );
      },
    );
  }

  // 🔹 جلب الفواتير مع Pagination
  Future<void> fetchBills(FetchBillsParam param) async {
    if (state.isLoading || !state.hasMore) return;

    final pageNumber = param.page ?? state.currentPage;

    emit(
      state.copyWith(
        isLoading: true,
        status: pageNumber == 1 ? BillsStatus.loading : state.status,
      ),
    );

    final result = await billsUseCase.call(param);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: BillsStatus.failure,
            errorMessage: failure.errMessage,
          ),
        );
      },
          (billsPage) {
        if (billsPage.bills.isEmpty && pageNumber == 1) {
          emit(
            state.copyWith(
              isLoading: false,
              bills: [],
              status: BillsStatus.empty,
              hasMore: false,
            ),
          );
          return;
        }

        final updatedBills = pageNumber == 1
            ? billsPage.bills
            : [...state.bills, ...billsPage.bills];

        final more = billsPage.nextPage != null;

        emit(
          state.copyWith(
            isLoading: false,
            bills: updatedBills,
            hasMore: more,
            currentPage: more ? pageNumber + 1 : pageNumber,
            status: BillsStatus.success,
          ),
        );
      },
    );
  }

  Future<void> createBills(CreateBillsParam param) async {
    emit(state.copyWith(status: BillsStatus.createLoading));
    final result = await createBillsUseCase.call(param);
    result.fold((failure) {
      print("🔥 EMIT CreateBillsFailureState: ${failure.errMessage}");

      emit(
        state.copyWith(
          status: BillsStatus.createFailure,
          errorMessage: failure.errMessage,
          bills: state.bills,
        ),
      );
    }, (bills) {
      final updateBills = List<BillsEntity>.from(state.bills)..insert(0, bills);
      emit(state.copyWith(status: BillsStatus.createSuccess,bills: updateBills));
    });
  }

  void toggleSearch() {
    if (state.isSearching) {
      emit(state.copyWith(isSearching: false, searchQuery: ''));
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }

  void searchBills(String query) {
    final trimmedQuery = query.trim();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          isSearching: false,
          currentPage: 1,
          hasMore: true,
          status: BillsStatus.loading,
        ),
      );
      fetchBills(FetchBillsParam(page: 1, query: null,branch: ['all']));
      return;
    }

    if (trimmedQuery.isNotEmpty && trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          searchQuery: trimmedQuery,
          isSearching: true,
          bills: [],
          currentPage: 1,
          hasMore: true,
          status: BillsStatus.searchLoading,
        ),
      );
      fetchBills(FetchBillsParam(page: 1, query: trimmedQuery,branch: ['all']));
    }
  }

  void searchActiveBills(String query) {
    final trimmedQuery = query.trim();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          isSearching: false,
          currentPage: 1,
          hasMore: true,
          status: BillsStatus.activeLoading,
        ),
      );
      fetchActiveBills(FetchBillsParam(page: 1, query: null,branch: ['all']));
      return;
    }

    if (trimmedQuery.isNotEmpty && trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          searchQuery: trimmedQuery,
          isSearching: true,
          bills: [],
          currentPage: 1,
          hasMore: true,
          status: BillsStatus.searchLoading,
        ),
      );
      fetchActiveBills(FetchBillsParam(page: 1, query: trimmedQuery,branch: ['all']));
    }
  }

  Future<void> onRefresh() async {
    emit(
      state.copyWith(
        searchQuery: '',
        status: BillsStatus.loading,
        currentPage: 1,
        hasMore: true,
        bills: [],
      ),
    );

    await fetchBills(FetchBillsParam(page: 1,branch: ['all']));
  }

  Future<void> onRefreshActiveBills() async {
    emit(
      state.copyWith(
        searchQuery: '',
        status: BillsStatus.loading,
        currentPage: 1,
        hasMore: true,
        bills: [],
      ),
    );

    await fetchActiveBills(FetchBillsParam(page: 1,branch: ['all']));
  }
}

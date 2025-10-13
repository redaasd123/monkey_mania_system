import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/create_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_active_bills_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/param/return_product_param.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/return_products_use_case.dart';

import '../../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../domain/entity/get_one_bills_coffee_entity.dart';
import '../../../param/create_bills_coffee_param.dart';

part 'coffee_bills_state.dart';

class CoffeeBillsCubit extends Cubit<BillsCoffeeState> {
  CoffeeBillsCubit(
    this.fetchBillsCoffeeUSeCase,
    this.fetchActiveBillsCoffeeUSeCase,
    this.createBillsCoffeeUSeCase,
    this.returnProductsUseCase,
  ) : super((BillsCoffeeState()));
  final FetchBillsCoffeeUSeCase fetchBillsCoffeeUSeCase;
  final FetchActiveBillsCoffeeUSeCase fetchActiveBillsCoffeeUSeCase;
  final CreateBillsCoffeeUSeCase createBillsCoffeeUSeCase;
  final ReturnProductsUseCase returnProductsUseCase;

  Future<void> fetchBillsCoffee(RequestParameters param) async {
    if (state.isLoading) return;

    final pageNumber = param.page ?? state.currentPage;

    emit(
      state.copyWith(
        isLoading: true,
        status: pageNumber == 1 ? CoffeeBillsStatus.loading : state.status,
      ),
    );

    final result = await fetchBillsCoffeeUSeCase.call(param);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: CoffeeBillsStatus.failure,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (billsPage) {
        if (billsPage.billsCoffeeEntity.isEmpty && pageNumber == 1) {
          emit(
            state.copyWith(
              isLoading: false,
              bills: [],
              status: CoffeeBillsStatus.empty,
              hasMore: false,
            ),
          );
          return;
        }

        dynamic updatedBills = pageNumber == 1
            ? billsPage.billsCoffeeEntity
            : [...state.bills, ...billsPage.billsCoffeeEntity];

        final more = billsPage.nextPage != null;

        emit(
          state.copyWith(
            isLoading: false,
            bills: updatedBills,
            hasMore: more,
            currentPage: more ? pageNumber + 1 : pageNumber,
            status: CoffeeBillsStatus.success,
          ),
        );
      },
    );
  }

  Future<void> fetchActiveBillsCoffee(RequestParameters param) async {
    if (state.isLoading) return;

    emit(
      state.copyWith(isLoading: true, status: CoffeeBillsStatus.activeLoading),
    );

    final result = await fetchActiveBillsCoffeeUSeCase.call(param);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: CoffeeBillsStatus.activeFailure,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (bills) {
        if (bills.isEmpty) {
          emit(
            state.copyWith(isLoading: false, status: CoffeeBillsStatus.empty),
          );
          return;
        }

        emit(
          state.copyWith(
            bills: bills,
            status: CoffeeBillsStatus.activeSuccess,
            isLoading: false,
          ),
        );
      },
    );
  }

  //

  Future<void> createBillsCoffeeCubit(CreateBillsPCoffeeParam param) async {
    emit(state.copyWith(status: CoffeeBillsStatus.createLoading));
    var result = await createBillsCoffeeUSeCase.call(param);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CoffeeBillsStatus.createFailure,
          errorMessage: failure.errMessage,
        ),
      ),
      (bill) {
        final updated = List<BillsCoffeeEntity>.from(state.bills)
          ..insert(0, bill);
        emit(
          state.copyWith(
            status: CoffeeBillsStatus.createSuccess,
            bills: updated,
          ),
        );
      },
    );
  }

  Future<void> returnProducts(ReturnProductsParam param) async {
    emit(state.copyWith(status: CoffeeBillsStatus.returnProductLoading));
    final result = await returnProductsUseCase.call(param);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CoffeeBillsStatus.returnProductFailure,
          errorMessage: failure.errMessage,
        ),
      ),
      (bill) {
        final updatedList = List<BillsCoffeeEntity>.from(state.bills);
        final index = updatedList.indexWhere((e)=>e.id==bill.id);
        if(index!=1){
          updatedList[index]=bill;
        }else{
          updatedList..insert(0, bill);
        }

        emit(
          state.copyWith(
            status: CoffeeBillsStatus.returnProductSuccess,
            bills: updatedList,
          ),
        );
      },
    );
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
          status: CoffeeBillsStatus.loading,
        ),
      );
      fetchBillsCoffee(
        RequestParameters(page: 1, query: null, branch: ['all']),
      );
      return;
    }

    if (trimmedQuery.isNotEmpty && trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          filters: state.filters.copyWith(query: trimmedQuery),
          searchQuery: trimmedQuery,
          isSearching: true,
          bills: [],
          currentPage: 1,
          hasMore: true,
          status: CoffeeBillsStatus.searchLoading,
        ),
      );
      fetchBillsCoffee(
        RequestParameters(page: 1, query: trimmedQuery, branch: ['all']),
      );
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
          status: CoffeeBillsStatus.activeLoading,
        ),
      );
      fetchActiveBillsCoffee(
        RequestParameters(page: 1, query: null, branch: ['all']),
      );
      return;
    }

    if (trimmedQuery.isNotEmpty && trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          filters: state.filters.copyWith(query: trimmedQuery),
          searchQuery: trimmedQuery,
          isSearching: true,
          bills: [],
          currentPage: 1,
          hasMore: true,
          status: CoffeeBillsStatus.searchLoading,
        ),
      );
      fetchActiveBillsCoffee(
        RequestParameters(page: 1, query: trimmedQuery, branch: ['all']),
      );
    }
  }

  Future<void> onRefresh() async {
    emit(
      state.copyWith(
        searchQuery: '',
        status: CoffeeBillsStatus.loading,
        currentPage: 1,
        hasMore: true,
        bills: [],
      ),
    );

    await fetchBillsCoffee(RequestParameters(page: 1, branch: ['all']));
  }

  Future<void> onRefreshActive() async {
    emit(
      state.copyWith(
        searchQuery: '',
        status: CoffeeBillsStatus.loading,
        currentPage: 1,
        hasMore: true,
        bills: [],
      ),
    );

    await fetchActiveBillsCoffee(RequestParameters(page: 1, branch: ['all']));
  }

  void setParam(RequestParameters param) {
    emit(state.copyWith(filters: param));
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/create_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_active_bills_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_one_coffee_bills_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

part 'coffee_bills_state.dart';

class CoffeeBillsCubit extends Cubit<CoffeeBillsState> {
  CoffeeBillsCubit(
    this.fetchBillsCoffeeUSeCase,
    this.fetchActiveBillsCoffeeUSeCase,
    this.getOneCoffeeBillsUseCase,
    this.createBillsCoffeeUSeCase,
  ) : super(CoffeeBillsInitial());
  final FetchBillsCoffeeUSeCase fetchBillsCoffeeUSeCase;
  final FetchActiveBillsCoffeeUSeCase fetchActiveBillsCoffeeUSeCase;
  final GetOneCoffeeBillsUseCase getOneCoffeeBillsUseCase;
  final CreateBillsCoffeeUSeCase createBillsCoffeeUSeCase;

  int currentPage = 1;
  bool hasMore = true;
  bool isLoading = false;
  List<BillsCoffeeEntity> allBills = [];

  bool isSearching = false;

  String searchQuery = '';




Future<void> fetchBillsCoffee(FetchBillsParam param) async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    final page = currentPage;

    if (page == 1) emit(CoffeeBillsLoadingState());

    final result = await fetchBillsCoffeeUSeCase.call(param);

    result.fold(
          (failure) {
        isLoading = false;
        emit(CoffeeBillsFailureState(errMessage: failure.errMessage));
      },
          (billsPage) {
        isLoading = false;

        if (page == 1) allBills.clear();

        allBills.addAll(billsPage.billsCoffeeEntity);

        hasMore = billsPage.nextPage != null;
        if (hasMore) currentPage = page + 1;

        if (allBills.isEmpty) {
          emit(BillsEmptyState());
        } else {
          emit(CoffeeBillsSuccessState(bills: List.from(allBills))); // 👈 مهم عشان Flutter يعمل rebuild
        }
      },
    );
  }



  Future<void> fetchActiveBillsCoffee(FetchBillsParam param) async {
    isLoading = true;

    if (currentPage == 1) {
      emit(isSearching ? ActiveBillsSearchLoading() : ActiveCoffeeBillsLoadingState());
    }

    final result = await fetchActiveBillsCoffeeUSeCase.call(param);

    result.fold(
          (failure) {
        isLoading = false;
        emit(ActiveCoffeeBillsFailureState(errMessage: failure.errMessage));
      },
          (bills) {
        isLoading = false;

        if (bills.isEmpty && currentPage == 1) {
          allBills.clear();
          emit(BillsEmptyState());
          return;
        }

        if (currentPage == 1) allBills.clear();
        allBills.addAll(bills);

        hasMore = bills.isNotEmpty; // أو حسب API لو فيه nextPage
        if (hasMore) currentPage++;

        emit(ActiveCoffeeBillsSuccessState(bills: allBills));
      },
    );
  }

  Future<void> getOneBillsCoffee(int id) async {
    emit(GetOneBillsCoffeeLoadingState());
    var result = await getOneCoffeeBillsUseCase.call(id);
    result.fold(
      (failure) {
        emit(GetOneBillsCoffeeFailureState(errMessage: failure.errMessage));
      },
      (bills) {
        emit(GetOneBillsCoffeeSuccessState(bills: bills));
      },
    );
  }

  Future<void> createBillsCoffeeCubit(CreateBillsPCoffeeParam param) async {
    emit(CreateBillsCoffeeLoadingState());
    var result = await createBillsCoffeeUSeCase.call(param);
    result.fold(
      (failure) =>
          emit(CreateBillsCoffeeFailureState(errMessage: failure.errMessage)),
      (success) => emit(CreateBillsCoffeeSuccessState()),
    );
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      searchQuery = '';
      currentPage = 1;
      hasMore = true;
      fetchBillsCoffee(FetchBillsParam(page: 1));
    }
  }

  void searchBills(String query) {
    searchQuery = query;
    currentPage = 1;
    hasMore = true;
    allBills.clear(); // امسح القائمة القديمة
    isLoading = false; // reset
    emit(CoffeeBillsLoadingState()); // عرض لودينج أثناء البحث
    fetchBillsCoffee(FetchBillsParam(query: query, page: currentPage));
  }

  void searchActiveBills(String query) {
    searchQuery = query;
    currentPage = 1;
    hasMore = true;
    allBills.clear();
    isLoading = false;
    emit(ActiveBillsSearchLoading()); // لودينج البحث
    fetchActiveBillsCoffee(FetchBillsParam(query: query, page: currentPage));
  }


}


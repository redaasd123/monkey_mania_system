import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_active_bills_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/fetch_bills_coffee_use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_one_coffee_bills_use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

part 'coffee_bills_state.dart';

class CoffeeBillsCubit extends Cubit<CoffeeBillsState> {
  CoffeeBillsCubit(
    this.fetchBillsCoffeeUSeCase,
    this.fetchActiveBillsCoffeeUSeCase, this.getOneCoffeeBillsUseCase,
  ) : super(CoffeeBillsInitial());
  final FetchBillsCoffeeUSeCase fetchBillsCoffeeUSeCase;
  final FetchActiveBillsCoffeeUSeCase fetchActiveBillsCoffeeUSeCase;
  final GetOneCoffeeBillsUseCase getOneCoffeeBillsUseCase;

  Future<void> fetchBillsCoffee(FetchBillsParam param) async {
    emit(CoffeeBillsLoadingState());
    var result = await fetchBillsCoffeeUSeCase.call(param);
    result.fold(
      (failure) {
        emit(CoffeeBillsFailureState(errMessage: failure.errMessage));
      },
      (bills) {
        emit(CoffeeBillsSuccessState(bills: bills));
      },
    );
  }

  Future<void> fetchActiveBillsCoffee(FetchBillsParam param) async {
    emit(ActiveCoffeeBillsLoadingState());
    var result = await fetchBillsCoffeeUSeCase.call(param);
    result.fold(
      (failure) {
        emit(ActiveCoffeeBillsFailureState(errMessage: failure.errMessage));
      },
      (bills) {
        emit(ActiveCoffeeBillsSuccessState(bills: bills));
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
}

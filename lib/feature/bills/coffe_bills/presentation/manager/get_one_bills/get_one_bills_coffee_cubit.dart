import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/get_one_bills_coffee_entity.dart';
import '../../../domain/use_case/get_one_coffee_bills_use_case.dart';

part 'get_one_bills_coffee_state.dart';

class GetOneBillsCoffeeCubit extends Cubit<GetOneBillsCoffeeState> {
  GetOneBillsCoffeeCubit(this.getOneCoffeeBillsUseCase)
      : super(const GetOneBillsCoffeeState());

  final GetOneCoffeeBillsUseCase getOneCoffeeBillsUseCase;

  Future<void> getOneBillsCoffee(int id) async {
    emit(state.copyWith(status: GetOneBillsCoffeeStatus.getOneLoading));

    final result = await getOneCoffeeBillsUseCase.call(id);

    result.fold(
          (failure) => emit(
        state.copyWith(
          status: GetOneBillsCoffeeStatus.getOneFailure,
          errMessage: failure.errMessage,
        ),
      ),
          (bills) => emit(
        state.copyWith(
          status: GetOneBillsCoffeeStatus.getOneSuccess,
          getOneBills: bills,
        ),
      ),
    );
  }
}

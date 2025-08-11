import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entity/get_one_bills_entity.dart';
import '../../domain/use_case/get_one_bills_use_case.dart';

part 'get_one_bills_state.dart';

class GetOneBillsCubit extends Cubit<GetOneBillsState> {
  final GetOneBillUseCase getOneBillUseCase;

  GetOneBillsCubit(this.getOneBillUseCase) : super(GetOneBillsInitial());

  Future<void> getOneBills(num id) async {
    emit(GetOneBillsLoadingState());
    var result = await getOneBillUseCase.call(id);
    result.fold(
      (failure) {
        emit(GetOneBillsFailureState(errMessage: failure.errMessage));
      },
      (bills) {
        emit(GetOneBillsSuccessState(bills: bills));
      },
    );
  }
}

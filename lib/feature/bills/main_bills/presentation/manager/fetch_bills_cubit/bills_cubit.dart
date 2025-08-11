import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../../domain/entity/Bills_entity.dart';
import '../../../domain/use_case/fetch_bills_use_case.dart';
import '../../view/widget/param/fetch_bills_param.dart';

part 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  final BillsUseCase billsUseCase;

  BillsCubit(this.billsUseCase) : super(BillsInitial());

  Future<void> fetchBills(FetchBillsParam param) async {
    emit(BillsLoadingState());

    var result = await billsUseCase.call(param);
    result.fold(
      (failure) => emit(BillsFailureState(errMessage: failure.errMessage)),
      (bills) => emit(BillsSuccessState(bills: bills)),
    );
  }
}

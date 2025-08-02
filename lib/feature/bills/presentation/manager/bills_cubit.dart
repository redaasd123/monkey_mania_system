import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/domain/use_case/bills_use_case.dart';

import '../../domain/repo/fetch_bills_param.dart';

part 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  final BillsUseCase billsUseCase;

  BillsCubit(this.billsUseCase) : super(BillsInitial());

  Future<void> fetchBills(FetchBillsPram param) async {
    emit(BillsLoadingState());

    var result = await billsUseCase.call(param);
    result.fold(
      (failure) => emit(BillsFailureState(errMessage: failure.errMessage)),
      (bills) => emit(BillsSuccessState(bills: bills)),
    );
  }
}

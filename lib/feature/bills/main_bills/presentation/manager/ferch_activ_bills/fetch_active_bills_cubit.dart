import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/Bills_entity.dart';
import '../../../domain/use_case/fetch_active_bills_use_case.dart';
import '../../view/widget/param/fetch_bills_param.dart';

part 'fetch_active_bills_state.dart';

class FetchActiveBillsCubit extends Cubit<FetchActiveBillsState> {
  FetchActiveBillsCubit(this.fetchActiveBillsUseCase)
    : super(FetchActiveBillsInitial());
  final FetchActiveBillsUseCase fetchActiveBillsUseCase;

  Future<void> fetchActiveBills(FetchBillsParam param) async {
    emit(FetchActiveBillsLoadingState());

    var result = await fetchActiveBillsUseCase.call(param);
    result.fold(
      (failure) =>
          emit(FetchActiveBillsFailureState(errMessage: failure.errMessage)),
      (bills) => emit(FetchActiveBillsSuccessState(bills: bills)),
    );
  }
}

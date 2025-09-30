import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/csv_analytics/domain/entity/analytic_type_entity.dart';
import 'package:monkey_app/feature/csv_analytics/domain/use_case/analytic_use_case.dart';

part 'anlytic_state.dart';

class AnalyticCubit extends Cubit<AnalyticState> {
  AnalyticCubit(this.analyticTypeUseCase) : super(AnalyticState());

  final AnalyticTypeUseCase analyticTypeUseCase;

  Future<void> fetchAnalyticType() async {
    emit(state.copyWith(status: AnalyticStatus.loading));
    final result = await analyticTypeUseCase.call(NoParam());
    result.fold(
      (failure) => emit(
        state.copyWith(
          errMessage: failure.errMessage,
          status: AnalyticStatus.failure,
        ),
      ),
      (data) =>
          emit(state.copyWith(data: data, status: AnalyticStatus.success)),
    );

  }
  void setParam(FetchBillsParam param){
    emit(state.copyWith(filters: param));
  }
}

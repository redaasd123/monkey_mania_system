import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/bills/domain/use_case/close_bills_use_case.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/close_bills_param.dart';

part 'close_bills_state.dart';

class CloseBillsCubit extends Cubit<CloseBillsState> {
  CloseBillsCubit(this.closeBillsUseCase) : super(CloseBillsInitial());
  final CloseBillsUseCase closeBillsUseCase;

  Future<void> closeBills(CloseBillsParam param)async{
    emit(CloseBillsLoading());
    var result = await closeBillsUseCase.call(param);
    result.fold((failure) =>
        emit(CloseBillsFailure(errMessage: failure.errMessage))
        , (bills)=>emit(CloseBillsSuccess()));
  }
}

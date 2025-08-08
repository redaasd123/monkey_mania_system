import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/bills/domain/use_case/create_bills_use_case.dart';
import 'package:monkey_app/feature/bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/apply_discount_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/create_bills_param.dart';

import '../../../domain/use_case/apply_discount_use_case.dart';

part 'create_bills_state.dart';

class CreateBillsCubit extends Cubit<CreateBillsState> {
  CreateBillsCubit(this.createBillsUseCase,) : super(CreateBillsInitial());
  final CreateBillsUseCase createBillsUseCase;
  Future<void> createBills(CreateBillsParam param) async {
    emit(CreateBillsLoadingState());
    var result = await createBillsUseCase.call(param);
    result.fold((failure) =>
        emit(CreateBillsFailureState(errMessage: failure.errMessage))
        , (bills)=>emit(CreateBillsSuccessState()));

  }

}

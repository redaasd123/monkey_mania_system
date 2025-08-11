import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_case/apply_discount_use_case.dart';
import '../../view/widget/apply_discount_param.dart';

part 'apply_discount_state.dart';

class ApplyDiscountCubit extends Cubit<ApplyDiscountState> {
  ApplyDiscountCubit(this.applyDiscountUseCase) : super(ApplyDiscountInitial());

  final ApplyDiscountUseCase applyDiscountUseCase;

  Future<void> applyDiscount(ApplyDiscountParams param) async {
    emit(ApplyDiscountLoadingState());
    var result = await applyDiscountUseCase.call(param);
    result.fold(
      (failure) =>
          emit(ApplyDiscountFailureState(errMessage: failure.errMessage)),
      (bills) => emit(ApplyDiscountSuccessState()),
    );
  }
}

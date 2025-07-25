import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/update_children_use_case.dart';

import '../../../../../core/param/update_children_param/update_children_param.dart';


part 'update_state.dart';

class UpdateChildrenCubit extends Cubit<UpdateChildrenState> {
  UpdateChildrenCubit({required this.updateChildrenUseCase}) : super(UpdateInitialState());

  final UpdateChildrenUseCase updateChildrenUseCase;

  Future<void> updateChildren(UpdateChildrenParam param) async {
    emit(UpdateLoadingState());
    var result = await updateChildrenUseCase.call(param);
    result.fold(
      (failure) => emit(UpdateFailureState(errMessage: failure.errMessage)),
      (success) => emit(UpdateSuccessState()),
    );
  }
}


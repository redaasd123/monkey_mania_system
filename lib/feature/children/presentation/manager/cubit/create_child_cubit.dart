import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/errors/off_line_failure.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/create_chil_use_case.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import '../../../../../core/param/create_children_params/create_children_params.dart';

part 'create_child_state.dart';

class CreateChildCubit extends Cubit<CreateChildState> {
  final CreateChildUseCase createChildUseCase;

  CreateChildCubit(this.createChildUseCase) : super(CreateChildInitial());
  Future<void> createChildren(CreateChildrenParam param) async {
    emit(CreateChildLoading());
    final result = await createChildUseCase.call(param);
    result.fold(
          (failure) {
        if (failure is OfflineFailure) {
          emit(CreateChildOfflineSaved('  لم يتوفر اتصال باالانترنت وتم الحفظ مؤقتا وسيتم الارسال عندما يتوفر الاتصال بالانترنت ويستغرق هذا الامر بضع دقائق '));
        } else {
          emit(CreateChildFailure(errMessage: failure.errMessage));
        }
      },
          (success) => emit(CreateChildSuccess()),
    );
  }
}

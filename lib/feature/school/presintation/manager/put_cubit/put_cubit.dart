import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/use_case/params/put_params.dart'; // ✅ الملف الصحيح
import 'package:monkey_app/feature/school/data/model/school_model.dart';
import 'package:monkey_app/feature/school/domain/use_case/update_school_use_case.dart';

part 'put_state.dart';

class UpdateSchoolCubit extends Cubit<UpdateState> {
  final UpdateSchoolUseCase updateSchoolUseCase;

  UpdateSchoolCubit({required this.updateSchoolUseCase}) : super(PutInitialState());

  Future<void> updateSchool({
    required String name,
    required String address,
    String? notes,
    required int id,
  }) async {
    if (isClosed) return;
    emit(UpdateLoadingState());

    final result = await updateSchoolUseCase.call(
      UpdateSchoolParam(id: id, name: name, address: address, notes: notes),
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        if (!isClosed) emit(UpdateFailureState(errMessage: failure.errMessage));
      },
      (success) {
        if (!isClosed) emit(UpdateSuccessState(schoolModel: success));
      },
    );
  }



}

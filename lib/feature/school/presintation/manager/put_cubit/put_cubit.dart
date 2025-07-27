import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/errors/off_line_failure.dart';
import 'package:monkey_app/feature/school/data/model/school_model.dart';
import 'package:monkey_app/feature/school/domain/use_case/update_school_use_case.dart';

import '../../../../../core/param/update_school_param/update_school_param.dart';

part 'put_state.dart';

class UpdateSchoolCubit extends Cubit<UpdateState> {
  final UpdateSchoolUseCase updateSchoolUseCase;

  UpdateSchoolCubit({required this.updateSchoolUseCase})
    : super(PutInitialState());

  Future<void> updateSchool(UpdateSchoolParam param) async {
    if (isClosed) return;
    emit(UpdateLoadingState());

    final result = await updateSchoolUseCase.call(param);

    if (isClosed) return;
    result.fold(
      (failure) {
        if (state is OfflineFailure) {
          emit(
            UpdateOfflineState(
              errMessage:
              'لم يتوفر اتصال بالإنترنت وتم الحفظ مؤقتاً، وسيتم الإرسال تلقائياً عند توفر الاتصال. قد يستغرق هذا الأمر بضع دقائق.'
          ));
        } else {
          if (!isClosed)
            emit(UpdateFailureState(errMessage: failure.errMessage));
        }
        ;
      },
      (success) {
        if (!isClosed) emit(UpdateSuccessState(schoolModel: success));
      },
    );
  }
}

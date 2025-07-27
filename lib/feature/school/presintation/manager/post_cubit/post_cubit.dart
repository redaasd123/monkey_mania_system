import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/errors/off_line_failure.dart';
import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';
import 'package:monkey_app/feature/school/data/model/school_model.dart';
import 'package:monkey_app/feature/school/domain/use_case/post_school_use_case.dart';

part 'post_state.dart';

class CreateSchoolCubit extends Cubit<CreateSchoolState> {
  CreateSchoolCubit(this.postSchoolUseCase) : super(CreateInitialState());

  final PostSchoolUseCase postSchoolUseCase;

  Future<void> createSchool(CreateSchoolParam param) async {
    emit(CreateLoadingState());
    var result = await postSchoolUseCase.call(param);
    result.fold((failure) {
      if (state is OfflineFailure) {
        emit(CreateOfflineState(errMessage: ' لم يتوفر اتصال باالانترنت وتم الحفظ مؤقتا وسيتم الارسال عندما يتوفر الاتصال بالانترنت ويستغرق هذا الامر بضع دقائق'));
      } else {
        emit(CreateFailureState(errMessage: failure.errMessage));
      }
    }, (success) => emit(CreateSuccessState(schoolModel: success)));
  }
}

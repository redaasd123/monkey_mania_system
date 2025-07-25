import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/use_case/params/post_school_param.dart';
import 'package:monkey_app/feature/school/data/model/school_model.dart';
import 'package:monkey_app/feature/school/domain/use_case/post_school_use_case.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postSchoolUseCase) : super(PostInitial());

  final PostSchoolUseCase postSchoolUseCase;

  Future<void>postSchool({
    required String name,
    required String address,
    String? notes,
  }) async {
    emit(PostLoadingState());
    var result = await postSchoolUseCase.call(
      PostSchoolParam(name: name, address: address, notes: notes),
    );
    result.fold(
      (failure) => emit(PostFailureState(errMessage: failure.errMessage)),
      (success) => emit(PostSuccessState(schoolModel: success)),
    );
  }



}

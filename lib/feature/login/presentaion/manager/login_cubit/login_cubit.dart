import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/login/domain/use_case/login_repo_use_case.dart';

import '../../../../../core/param/login_param/login_param.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoUseCase loginRepoUseCase;

  LoginCubit(this.loginRepoUseCase) : super(LoginInitialState());

  Future<void> loginUser({required String number, required String pass}) async {
    emit(LoginLoadingState());

    try {
      final result = await loginRepoUseCase.call(
        LoginParam(pass: pass, number: number),
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(LoginFailureState(errMessage: failure.errMessage));
        },
        (login) {
          if (isClosed) return;
          emit(LoginSuccessState());
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        LoginFailureState(errMessage: '⚠️ حدث خطأ غير متوقع: ${e.toString()}'),
      );
    }
  }
}

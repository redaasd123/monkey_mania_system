import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/login/domain/use_case/login_repo_use_case.dart';

import '../../../../../core/param/login_param/login_param.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepoUseCase) : super(LoginInitialState());
  final LoginRepoUseCase loginRepoUseCase;

  Future<void> loginUser({required String number, required String pass}) async {
    emit(LoginLoadingState());


    var result = await loginRepoUseCase.call(
      LoginParam(pass: pass, number: number),
    );

    result.fold(
      (failure) {
        emit(LoginFailureState(errMessage: failure.errMessage));
      },
      (login) {
        emit(LoginSuccessState());
      },
    );
  }
}

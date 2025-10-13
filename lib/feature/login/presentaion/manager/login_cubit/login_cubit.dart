// login_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/login/domain/use_case/login_repo_use_case.dart';
import '../../../../../core/param/login_param/login_param.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoUseCase loginRepoUseCase;

  LoginCubit(this.loginRepoUseCase) : super(const LoginState());

  Future<void> loginUser({
    required String number,
    required String pass,
  }) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final result = await loginRepoUseCase(
        LoginParam(pass: pass, number: number),
      );

      result.fold(
            (failure) => emit(
          state.copyWith(
            status: LoginStatus.failure,
            errMessage: failure.errMessage,
          ),
        ),
            (_) => emit(
          state.copyWith(status: LoginStatus.success),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errMessage: '⚠️ حدث خطأ غير متوقع: ${e.toString()}',
        ),
      );
    }
  }
}

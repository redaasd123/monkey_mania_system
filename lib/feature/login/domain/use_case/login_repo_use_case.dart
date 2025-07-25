  import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/params/login_param.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/login/domain/repo/login_repo.dart';

class LoginRepoUseCase extends MyUseCase<dynamic,LoginParam>{
  final LoginRepo loginRepo;
  LoginRepoUseCase({required this.loginRepo});
  @override
  Future<Either<Failure, dynamic>> call(LoginParam param) async {
    return await loginRepo.LoginUser(
      pass: param.pass,
        phone: param.number
    );

  }
}
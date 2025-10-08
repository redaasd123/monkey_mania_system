import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/users_repo.dart';

class CreateUserUseCase extends MyUseCase<UserDataEntity,CreateUserParam>{
  final UsersRepo usersRepo;

  CreateUserUseCase({required this.usersRepo});
  @override
  Future<Either<Failure, UserDataEntity>> call(CreateUserParam param)async {
    return await  usersRepo.createUsers(param);
  }
}
import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/update_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/users_repo.dart';

class UpdateUserUseCase extends MyUseCase<UserDataEntity,UpdateUserParam>{
  final UsersRepo usersRepo;

  UpdateUserUseCase({required this.usersRepo});
  @override
  Future<Either<Failure, UserDataEntity>> call(UpdateUserParam param) async{
return await usersRepo.updateUsers(param);
  }
}
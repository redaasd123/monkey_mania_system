import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/users/domain/entity/user_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/users_repo.dart';

class FetchUserUseCase extends MyUseCase<UserEntity,FetchBillsParam>{
  final UsersRepo usersRepo;

  FetchUserUseCase({required this.usersRepo});
  @override
  Future<Either<Failure, UserEntity>> call(FetchBillsParam param)async{
  return await usersRepo.fetchUsers(param);
  }
}
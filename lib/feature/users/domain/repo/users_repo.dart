import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/entity/user_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/update_user_param.dart';

abstract class UsersRepo {
  Future<Either<Failure, UserEntity>> fetchUsers(FetchBillsParam param);

  Future<Either<Failure, UserDataEntity>> createUsers(CreateUserParam param);

  Future<Either<Failure, UserDataEntity>> updateUsers(UpdateUserParam param);
}

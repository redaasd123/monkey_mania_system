import 'package:monkey_app/feature/users/data/model/user_model.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/entity/user_entity.dart';

extension GetUserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      next: next,
      previous: previous,
      userData: results?.map((c) => c.toEntity()).toList()??[],
    );
  }
}

extension GetUserData on UsersResults {
  UserDataEntity toEntity() {
    return UserDataEntity(
      email: email,
      id: id??0,
      name: username ?? '',
      role: role ?? '',
      phoneNumber: phoneNumber ?? '',
    );
  }
}

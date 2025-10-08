import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/users/data/model/mapper.dart';
import 'package:monkey_app/feature/users/data/model/user_model.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/entity/user_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/update_user_param.dart';

import '../../../../core/utils/api_serviece.dart';
import '../../../../core/utils/extract_page.dart';
import '../../../../core/utils/service_locator.dart';

abstract class UserRemoteDataSource {
  Future<UserEntity> fetchUsers(FetchBillsParam param);

  Future<UserDataEntity> createUser(CreateUserParam param);

  Future<UserDataEntity> updateUser(UpdateUserParam param);
}

class UserDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<UserDataEntity> createUser(CreateUserParam param) async {
    var result = await getIt.get<Api>().post(
      endPoint: 'user/create/',
      body: param.toJson(),
    );
    return UsersResults.fromJson(result.data).toEntity();
  }

  @override
  Future<UserEntity> fetchUsers(FetchBillsParam param) async {
    var result = await getIt.get<Api>().get(
      endPoint: 'user/all/?${param.toQueryParams()}',
    );
    final List<UserDataEntity> userData = [];
    for (var item in result['results']) {
      userData.add(UsersResults.fromJson(item).toEntity());
    }

    final allResult = UserEntity(
      next: extractPage(result['next']),
      previous: extractPage(result['previous']),
      userData: userData,
    );
    return allResult;
  }

  @override
  Future<UserDataEntity> updateUser(UpdateUserParam param) async {
    var result = await getIt.get<Api>().patch(
      endPoint: 'user/${param.id}/update/',
      body: param.toJson(),
    );
    return UsersResults.fromJson(result.data).toEntity();
  }
}

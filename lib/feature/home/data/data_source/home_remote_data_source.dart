import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/home/data/model/mapper.dart';
import 'package:monkey_app/feature/home/data/model/home_model.dart';

import '../../domain/entity/home_entity.dart';

abstract class HomeRemoteDataSource {
  Future<HomeEntity> fetchDashBoardData();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<HomeEntity> fetchDashBoardData() async {
    var result = await getIt.get<Api>().get(endPoint: 'dashboard/statistics');
    Map<String,dynamic> data=result;
    final homeModel = HomeModel.fromJson(data).toEntity();
    return homeModel;


  }

}
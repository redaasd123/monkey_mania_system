import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/home/data/model/home_model.dart';
import 'package:monkey_app/feature/home/data/model/mapper.dart';

import '../../domain/entity/home_entity.dart';

abstract class HomeRemoteDataSource {
  Future<HomeEntity> fetchDashBoardData(FetchBillsParam param);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<HomeEntity> fetchDashBoardData(FetchBillsParam param) async {
    var result = await getIt.get<Api>().get(
      endPoint: 'dashboard/statistics?${param.toQueryParams()}',
    );
    Map<String, dynamic> data = result;
    final homeModel = HomeModel.fromJson(data).toEntity();
    return homeModel;
  }
}

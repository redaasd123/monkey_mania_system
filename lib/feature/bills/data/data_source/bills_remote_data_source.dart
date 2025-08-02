import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/data/model/bills_model.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';

import '../../../../core/utils/api_serviece.dart';
import '../../domain/repo/fetch_bills_param.dart';

abstract class BillsRemoteDataSource {
  Future<List<BillsEntity>> fetchBills(FetchBillsPram param);
}

class BillsRemoteDataSourceImpl extends BillsRemoteDataSource {
  @override
  Future<List<BillsEntity>> fetchBills(FetchBillsPram param) async {
    var result = await getIt.get<Api>().get(
        endPoint: 'bill/',queryParameters: param.toMap());
    List<BillsEntity> listBills=[];
    for(var item in result){
      listBills.add(BillsModel.fromJson(item));
    }
    return listBills;
  }
}
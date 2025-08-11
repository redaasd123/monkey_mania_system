import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/bills_coffee_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_one_coffee_bills_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/mapper.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

abstract class BillsCoffeeDataSource{
  Future<List<BillsCoffeeEntity>> fetchBillsCoffee(FetchBillsParam param);
  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(FetchBillsParam param);
  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id);
}

class BillsCoffeeDataSourceImpl extends BillsCoffeeDataSource{
  @override
  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(FetchBillsParam param) async{
var result = await getIt.get<Api>().get(endPoint: 'bill/active/all'
,queryParameters: param.toQueryParams());
List<BillsCoffeeEntity> bills = [];
for(var item in result){
  bills.add(BillsCoffeeModel.fromJson(item).toEntity());
}
return bills;
  }

  @override
  Future<List<BillsCoffeeEntity>> fetchBillsCoffee(FetchBillsParam param) async{
    var result = await getIt.get<Api>().get(endPoint: 'product_bill/all'
        ,queryParameters: param.toQueryParams());
    List<BillsCoffeeEntity> bills = [];
    for(var item in result){
      bills.add(BillsCoffeeModel.fromJson(item).toEntity());
    }
    return bills;
  }

  @override
  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id)async {
var result = await getIt.get<Api>().get(endPoint: 'product_bill/${id}/');
return GetOneCoffeeBillsModel.fromJson(result).toEntity();
  }
}
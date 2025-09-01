import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/bills_coffee_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_one_coffee_bills_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/mapper.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../domain/entity/coffee_bills_page_entity.dart';

abstract class BillsCoffeeDataSource {
  Future<BillsCoffeePageEntity> fetchBillsCoffee(FetchBillsParam param);

  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(FetchBillsParam param);

  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id);

  Future<Unit> createBillsCoffee(CreateBillsPCoffeeParam param,);
}

class BillsCoffeeDataSourceImpl extends BillsCoffeeDataSource {
  @override
  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(
      FetchBillsParam param,) async {
    var result = await getIt.get<Api>().get(
      endPoint: 'product_bill/active/all',
      queryParameters: param.toQueryParams(),
    );
    List<BillsCoffeeEntity> bills = [];
    for (var item in result) {
      bills.add(BillsCoffeeModel.fromJson(item).toEntity());
    }
    return bills;
  }

  @override
  Future<BillsCoffeePageEntity> fetchBillsCoffee(FetchBillsParam param,) async {
    var result = await getIt.get<Api>().get(
      endPoint: 'product_bill/all',
      queryParameters: param.toQueryParams(),
    );

    List<BillsCoffeeEntity> bills = [];
    for (var item in result['results']) {
      bills.add(
          BillsCoffeeModel.fromJson(item as Map<String, dynamic>).toEntity());
    }


    int? extractPage(String? url) {
      if (url == null) return null;
      final uri = Uri.parse(url);
      return int.tryParse(uri.queryParameters['page'] ?? '');
    }
    return BillsCoffeePageEntity(
        billsCoffeeEntity: bills,  nextPage: extractPage(result['next']),
      previousPage: extractPage(result['previous']),);
  }


  @override
  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id) async {
    var result = await getIt.get<Api>().get(endPoint: 'product_bill/${id}/');
    return GetOneCoffeeBillsModel.fromJson(result).toEntity();
  }

  @override
  Future<Unit> createBillsCoffee(CreateBillsPCoffeeParam param,) async {
    var result = await getIt.get<Api>().put(
      endPoint: 'product_bill/create/',
      body: param.toJson(),
    );
    return result;
  }
}

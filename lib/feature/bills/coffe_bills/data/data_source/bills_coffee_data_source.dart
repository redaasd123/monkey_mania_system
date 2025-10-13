import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/bills_coffee_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_all_layers_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_layer1_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_one_coffee_bills_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/mapper.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';

import '../../../../../core/utils/extract_page.dart';
import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../domain/entity/coffee_bills_page_entity.dart';

abstract class BillsCoffeeDataSource {
  Future<BillsCoffeePageEntity> fetchBillsCoffee(RequestParameters param);

  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(RequestParameters param);

  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id);

  Future<BillsCoffeeEntity> createBillsCoffee(CreateBillsPCoffeeParam param);

  Future<List<LayersEntity>> getLayerOne(RequestParameters param);

  Future<List<LayersEntity>> getLayerTow(RequestParameters param);

  Future<List<GetAllLayerEntity>> getAllLayers(RequestParameters param);
}

class BillsCoffeeDataSourceImpl extends BillsCoffeeDataSource {
  @override
  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(
    RequestParameters param,
  ) async {
    final url = 'product_bill/active/all?${param.toQueryParams()}';
    var response = await getIt.get<Api>().get(endPoint: url);

    List<BillsCoffeeEntity> bills = [];
    for (var item in response) {
      final entity = BillsCoffeeModel.fromJson(item).toEntity();
      bills.add(entity);
    }

    return bills;
  }

  @override
  Future<BillsCoffeePageEntity> fetchBillsCoffee(RequestParameters param) async {
    final url = 'product_bill/all?${param.toQueryParams()}';
    var response = await getIt.get<Api>().get(endPoint: url);

    List<BillsCoffeeEntity> bills = [];
    for (var item in response['results']) {
      final entity = BillsCoffeeModel.fromJson(
        item as Map<String, dynamic>,
      ).toEntity();
      bills.add(entity);
    }


    return BillsCoffeePageEntity(
      billsCoffeeEntity: bills,
      nextPage: extractPage(response['next']),
      previousPage: extractPage(response['previous']),
    );
  }

  @override
  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id) async {
    final url = 'product_bill/$id/';
    var response = await getIt.get<Api>().get(endPoint: url);
    return GetOneCoffeeBillsModel.fromJson(response).toEntity();
  }

  @override
  Future<BillsCoffeeEntity> createBillsCoffee(
    CreateBillsPCoffeeParam param,
  ) async {
    final url = 'product_bill/create/?${param.branchToQuery()}';
    final response = await getIt.get<Api>().post(
      endPoint: url,
      body: param.toJson(),
    );
    return BillsCoffeeModel.fromJson(response.data).toEntity();
  }

  @override
  Future<List<LayersEntity>> getLayerOne(RequestParameters param) async {
    final url = 'branch_product/layer1?${param.toQueryParams()}';
    var response = await getIt.get<Api>().get(endPoint: url);

    List<LayersEntity> layers = [];
    for (var item in response) {
      final entity = LayersModel.fromJson(item).toEntity();
      layers.add(entity);
    }

    return layers;
  }

  @override
  Future<List<LayersEntity>> getLayerTow(RequestParameters param) async {
    final url = 'branch_product/layer2?${param.toQueryParams()}';
    var response = await getIt.get<Api>().get(endPoint: url);

    List<LayersEntity> layers = [];
    for (var item in response) {
      final entity = LayersModel.fromJson(item).toEntity();
      layers.add(entity);
    }

    return layers;
  }

  @override
  Future<List<GetAllLayerEntity>> getAllLayers(RequestParameters param) async {
    final url = 'branch_product/all?${param.toQueryParams()}';
    var response = await getIt.get<Api>().get(endPoint: url);

    List<GetAllLayerEntity> layers = [];
    for (var item in response) {
      final model = GetAllLayersModel.fromJson(item);
      final entity = model.toEntity();
      layers.add(entity);
    }

    return layers;
  }
}

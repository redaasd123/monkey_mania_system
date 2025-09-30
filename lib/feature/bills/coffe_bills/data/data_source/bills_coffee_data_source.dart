import 'package:dartz/dartz.dart';
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
import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../domain/entity/coffee_bills_page_entity.dart';

abstract class BillsCoffeeDataSource {
  Future<BillsCoffeePageEntity> fetchBillsCoffee(FetchBillsParam param);

  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(FetchBillsParam param);

  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id);

  Future<BillsCoffeeEntity> createBillsCoffee(CreateBillsPCoffeeParam param);

  Future<List<LayersEntity>> getLayerOne(FetchBillsParam param);

  Future<List<LayersEntity>> getLayerTow(FetchBillsParam param);

  Future<List<GetAllLayerEntity>> getAllLayers(FetchBillsParam param);
}

class BillsCoffeeDataSourceImpl extends BillsCoffeeDataSource {
  @override
  Future<List<BillsCoffeeEntity>> fetchActiveBillsCoffee(
      FetchBillsParam param,
      ) async {
    final url = 'product_bill/active/all?${param.toQueryParams()}';
    print('📤 Fetch Active Bills Coffee from: $url');

    var response = await getIt.get<Api>().get(endPoint: url);
    print('📥 Raw Response: $response');

    List<BillsCoffeeEntity> bills = [];
    for (var item in response) {
      print('🔹 Raw Item: $item');
      final entity = BillsCoffeeModel.fromJson(item).toEntity();
      print('✅ Parsed Entity: $entity');
      bills.add(entity);
    }

    print('📦 Final Bills Count: ${bills.length}');
    return bills;
  }

  @override
  Future<BillsCoffeePageEntity> fetchBillsCoffee(FetchBillsParam param) async {
    final url = 'product_bill/all?${param.toQueryParams()}';
    print('📤 Fetch Bills Coffee from: $url');

    var response = await getIt.get<Api>().get(endPoint: url);
    print('📥 Raw Response: $response');

    List<BillsCoffeeEntity> bills = [];
    for (var item in response['results']) {
      print('🔹 Raw Item: $item');
      final entity =
      BillsCoffeeModel.fromJson(item as Map<String, dynamic>).toEntity();
      print('✅ Parsed Entity: $entity');
      bills.add(entity);
    }

    int? extractPage(String? url) {
      if (url == null) return null;
      final uri = Uri.parse(url);
      return int.tryParse(uri.queryParameters['page'] ?? '');
    }

    final pageEntity = BillsCoffeePageEntity(
      billsCoffeeEntity: bills,
      nextPage: extractPage(response['next']),
      previousPage: extractPage(response['previous']),
    );

    print('📦 Final BillsCoffeePageEntity: $pageEntity');
    return pageEntity;
  }

  @override
  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id) async {
    final url = 'product_bill/$id/';
    print('📤 Fetch One Bill Coffee from: $url');

    var response = await getIt.get<Api>().get(endPoint: url);
    print('📥 Raw Response: $response');

    final entity = GetOneCoffeeBillsModel.fromJson(response).toEntity();
    print('✅ Parsed Entity: $entity');

    return entity;
  }

  @override
  Future<BillsCoffeeEntity> createBillsCoffee(
      CreateBillsPCoffeeParam param) async {
    final url = 'product_bill/create/?${param.branchToQuery()}';
    print('📤 Creating Bill Coffee at: $url');
    print('📤 Request Body: ${param.toJson()}');


    // 🛑 Debug قبل ما يتنفذ request
    print('🚀 DEBUG: About to send POST request');
    print('   👉 URL: $url');
    print('   👉 Query Params: ${param.branchToQuery()}');
    print('   👉 Body: ${param.toJson()}');
    print('   👉 Headers: {Content-Type: application/json}');

    try {
      final response = await getIt.get<Api>().post(
        endPoint: url,
        body: param.toJson(),
      );

      print('📥 Raw Response: ${response.data}');

      final entity = BillsCoffeeModel.fromJson(response.data).toEntity();
      print('✅ Parsed Entity: $entity');

      return entity;
    } catch (e) {
      print('❌ ERROR OCCURRED BEFORE RESPONSE HANDLED: $e');
      rethrow;
    }
  }


  @override
  Future<List<LayersEntity>> getLayerOne(FetchBillsParam param) async {
    final url = 'branch_product/layer1?${param.toQueryParams()}';
    print('📤 Fetch Layer One from: $url');

    var response = await getIt.get<Api>().get(endPoint: url);
    print('📥 Raw Response: $response');

    List<LayersEntity> layers = [];
    for (var item in response) {
      print('🔹 Raw Item: $item');
      final entity = LayersModel.fromJson(item).toEntity();
      print('✅ Parsed Entity: $entity');
      layers.add(entity);
    }

    print('📦 Final LayerOne Count: ${layers.length}');
    return layers;
  }

  @override
  Future<List<LayersEntity>> getLayerTow(FetchBillsParam param) async {
    final url = 'branch_product/layer2?${param.toQueryParams()}';
    print('📤 Fetch Layer Two from: $url');

    var response = await getIt.get<Api>().get(endPoint: url);
    print('📥 Raw Response: $response');

    List<LayersEntity> layers = [];
    for (var item in response) {
      print('🔹 Raw Item: $item');
      final entity = LayersModel.fromJson(item).toEntity();
      print('✅ Parsed Entity: $entity');
      layers.add(entity);
    }

    print('📦 Final LayerTwo Count: ${layers.length}');
    return layers;
  }

  @override
  Future<List<GetAllLayerEntity>> getAllLayers(FetchBillsParam param) async {
    final url = 'branch_product/all?${param.toQueryParams()}';
    print('📤 Fetch All Layers from: $url');

    var response = await getIt.get<Api>().get(endPoint: url);
    print('📥 Raw Response: $response');

    List<GetAllLayerEntity> layers = [];
    for (var item in response) {
      print('🔹 Raw Item: $item');

      final model = GetAllLayersModel.fromJson(item);
      print('   🛠 Model created: $model');

      final entity = model.toEntity();
      print('✅ Entity created: $entity');

      layers.add(entity);
    }

    print('📦 Total Layers Count: ${layers.length}');
    return layers;
  }
}

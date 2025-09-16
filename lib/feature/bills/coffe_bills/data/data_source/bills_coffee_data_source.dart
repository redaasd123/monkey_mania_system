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
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

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

    var result = await getIt.get<Api>().get(endPoint: url);
    List<BillsCoffeeEntity> bills = [];
    for (var item in result) {
      bills.add(BillsCoffeeModel.fromJson(item).toEntity());
    }
    return bills;
  }

  @override
  Future<BillsCoffeePageEntity> fetchBillsCoffee(FetchBillsParam param) async {
    final url = 'product_bill/all?${param.toQueryParams()}';

    // 📨 Print request
    print('📩 Request sent to: $url');

    var result = await getIt.get<Api>().get(endPoint: url);

    // 📥 Print raw response
    print('📥 Raw Response: $result');

    List<BillsCoffeeEntity> bills = [];
    for (var item in result['results']) {
      final entity = BillsCoffeeModel.fromJson(item as Map<String, dynamic>).toEntity();
      bills.add(entity);

      // 🧾 Print each bill after parsing
      print('🧾 Bill parsed: $entity');
    }

    int? extractPage(String? url) {
      if (url == null) return null;
      final uri = Uri.parse(url);
      return int.tryParse(uri.queryParameters['page'] ?? '');
    }

    final pageEntity = BillsCoffeePageEntity(
      billsCoffeeEntity: bills,
      nextPage: extractPage(result['next']),
      previousPage: extractPage(result['previous']),
    );

    // 📦 Print final entity
    print('📦 Final BillsCoffeePageEntity: $pageEntity');

    return pageEntity;
  }

  @override
  Future<GetOneBillsCoffeeEntity> getOneBillsCoffee(int id) async {
    var result = await getIt.get<Api>().get(endPoint: 'product_bill/${id}/');
    return GetOneCoffeeBillsModel.fromJson(result).toEntity();
  }

  @override
  Future<BillsCoffeeEntity> createBillsCoffee(CreateBillsPCoffeeParam param) async {
    final response = await getIt.get<Api>().post(
      endPoint: 'product_bill/create/',
      body: param.toJson(),
    );
    return BillsCoffeeModel.fromJson(response.data).toEntity();
  }


  @override
  Future<List<LayersEntity>> getLayerOne(FetchBillsParam param) async {
    var result = await getIt.get<Api>().get(
      endPoint: 'branch_product/layer1?${param.toQueryParams()}',
    );
    List<LayersEntity> category = [];
    for (var item in result) {
      category.add(LayersModel.fromJson(item).toEntity());
    }
    return category;
  }

  @override
  Future<List<LayersEntity>> getLayerTow(FetchBillsParam param) async {
    var result = await getIt.get<Api>().get(
      endPoint: 'branch_product/layer2?${param.toQueryParams()}',
    );
    print('URL: branch_product/layer1?${param.toQueryParams()}');
    List<LayersEntity> category = [];
    for (var item in result) {
      category.add(LayersModel.fromJson(item).toEntity());
    }
    return category;
  }

  @override
  Future<List<GetAllLayerEntity>> getAllLayers(FetchBillsParam param) async {
    // تكوين الـ URL الكامل
    final fullUrl = 'branch_product/all?${param.toQueryParams()}';
    print('📤 Fetching All Layers from full URL: $fullUrl');

    // جلب البيانات من API
    var result = await getIt.get<Api>().get(
      endPoint: fullUrl,
    );

    print('📥 Raw result from API: $result');

    // تحويل كل عنصر من JSON → Model → Entity
    List<GetAllLayerEntity> layers = [];
    for (var item in result) {
      print('🔹 Processing item: $item');

      final model = GetAllLayersModel.fromJson(item);
      print('   Model created: $model');

      final entity = model.toEntity();
      print('   Entity created: ${entity.toString()}');

      layers.add(entity);
    }

    print('✅ Total layers fetched: ${layers.length}');
    for (var i = 0; i < layers.length; i++) {
      print('   Layer $i: ${layers[i]}');
    }

    return layers;
  }

}

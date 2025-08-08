import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/data/model/get_all_bills_model.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/close_bills_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/create_bills_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/fetch_active_bills.dart';

import '../../../../core/utils/api_serviece.dart';
import '../../presentation/view/widget/apply_discount_param.dart';
import '../../presentation/view/widget/param/fetch_bills_param.dart';

abstract class BillsRemoteDataSource {
  Future<List<BillsEntity>> fetchBills(FetchBillsParam param);

  Future<List<BillsEntity>> fetchActiveBills(FetchBillsParam param);

  Future<dynamic> createBills(CreateBillsParam param);
  Future<dynamic> closeBills(CloseBillsParam param);

  Future<dynamic> applyDiscount(ApplyDiscountParams param);
}

class BillsRemoteDataSourceImpl extends BillsRemoteDataSource {
  @override
  Future<List<BillsEntity>> fetchBills(FetchBillsParam param) async {
    final queryParams = param.toQueryParams();

    print('🔧 [FetchBills] Preparing API Request...');
    print('🔗 Endpoint: bill/active/all');
    print('📦 Query Params: $queryParams');

    final baseUrl =
        'https://monkey-mania-production.up.railway.app/bill/active/all?branch_id=1';
    final endpoint = 'bill/all';
    final fullUrl = Uri.parse(
      baseUrl,
    ).replace(path: endpoint, queryParameters: queryParams);
    print('🌐 Full Request URL: $fullUrl');

    var result = await getIt.get<Api>().get(
      endPoint: endpoint,
      queryParameters: queryParams,
    );

    print('✅ API Response Received');

    List<BillsEntity> listBills = [];
    for (var item in result) {
      listBills.add(GetAllBillsModel.fromJson(item));
    }

    return listBills;
  }

  @override
  Future<dynamic> createBills(CreateBillsParam param) async {
    var result = await getIt.get<Api>().post(
      endPoint: 'bill/create/',
      body: param.toJson(),
    );
    return result;
  }

  @override
  Future applyDiscount(ApplyDiscountParams param) async {
    var result = await getIt.get<Api>().put(
      endPoint: 'bill/${param.id}/apply_discount/',
      body: param.toJson(),
    );
  }

  @override
  Future<List<BillsEntity>> fetchActiveBills(
      FetchBillsParam param,
  ) async {


    final queryParams = param.toQueryParams();

    print('🔧 [FetchBills] Preparing API Request...');
    print('🔗 Endpoint: bill/active/all');
    print('📦 Query Params: $queryParams');

    final baseUrl =
        'https://monkey-mania-production.up.railway.app/bill/active/all?branch_id=1';
    final endpoint = 'bill/all';
    final fullUrl = Uri.parse(
      baseUrl,
    ).replace(path: endpoint, queryParameters: queryParams);
    print('🌐 Full Request URL: $fullUrl');





    var result = await getIt.get<Api>().get(
      endPoint: 'bill/active/all',
      queryParameters: param.toQueryParams(),
    );

    List<BillsEntity> bills = [];
    for (var item in result) {
      bills.add(GetAllBillsModel.fromJson(item));
    }
    return bills;
  }

  @override
  Future closeBills(CloseBillsParam param)async{
    var result = await getIt.get<Api>().put(endPoint: 'bill/${param.id}/close/',
        body: param.toJon());
    return result;
  }
}

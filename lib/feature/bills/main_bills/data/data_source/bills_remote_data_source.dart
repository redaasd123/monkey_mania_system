import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/data/model/mapper.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/entity/bills_page_entity.dart';

import '../../../../../core/utils/api_serviece.dart';
import '../../domain/entity/Bills_entity.dart';
import '../../domain/entity/get_one_bills_entity.dart';
import '../../presentation/view/widget/apply_discount_param.dart';
import '../../presentation/view/widget/param/close_bills_param.dart';
import '../../presentation/view/widget/param/create_bills_param.dart';
import '../../presentation/view/widget/param/fetch_bills_param.dart';
import '../model/all_bills_model/get_all_bills_model.dart';
import '../model/get_one_bills_model.dart';

abstract class BillsRemoteDataSource {
  Future<BillsPageEntity> fetchBills(FetchBillsParam param);

  Future<GetOneBillsEntity> getOneBills(num id);

  Future<List<BillsEntity>> fetchActiveBills(FetchBillsParam param);

  Future<BillsEntity> createBills(CreateBillsParam param);

  Future<dynamic> closeBills(CloseBillsParam param);

  Future<dynamic> applyDiscount(ApplyDiscountParams param);
}

class BillsRemoteDataSourceImpl extends BillsRemoteDataSource {
  @override
  Future<BillsPageEntity> fetchBills(FetchBillsParam param) async {
    final url = 'bill/all?${param.toQueryParams()}';
    var result = await getIt.get<Api>().get(endPoint: url);
    print('✅ API Response Received');

    List<BillsEntity> listBills = (result['results'] as List)
        .map((item) => GetAllBillsModel.fromJson(item as Map<String, dynamic>))
        .toList();

    int? extractPage(String? url) {
      if (url == null) return null;
      final uri = Uri.parse(url);
      return int.tryParse(uri.queryParameters['page'] ?? '');
    }

    return BillsPageEntity(
      bills: listBills,
      nextPage: extractPage(result['next']),
      previousPage: extractPage(result['previous']),
    );
  }

  @override
  Future<BillsEntity> createBills(CreateBillsParam param) async {
    var result = await getIt.get<Api>().post(
      endPoint: 'bill/create/',
      body: param.toJson(),
    );
    return GetAllBillsModel.fromJson(result);
  }

  @override
  Future applyDiscount(ApplyDiscountParams param) async {
    var result = await getIt.get<Api>().put(
      endPoint: 'bill/${param.id}/apply_discount/',
      body: param.toJson(),
    );
  }

  @override
  Future<List<BillsEntity>> fetchActiveBills(FetchBillsParam param) async {
    // final queryParams = param.toQueryParams();
    //
    // print('🔧 [FetchBills] Preparing API Request...');
    // print('🔗 Endpoint: bill/active/all');
    // print('📦 Query Params: $queryParams');
    //
    // final baseUrl =
    //     'https://monkey-mania-production.up.railway.app/bill/active/all?branch_id=1';
    // final endpoint = 'bill/all';
    // final fullUrl = Uri.parse(
    //   baseUrl,
    // ).replace(path: endpoint, queryParameters: queryParams);
    // print('🌐 Full Request URL: $fullUrl');
    final url = 'bill/active/all?${param.toQueryParams()}';
    var result = await getIt.get<Api>().get(endPoint: url);

    List<BillsEntity> bills = [];
    for (var item in result) {
      bills.add(GetAllBillsModel.fromJson(item));
    }
    return bills;
  }

  @override
  Future closeBills(CloseBillsParam param) async {
    var result = await getIt.get<Api>().put(
      endPoint: 'bill/${param.id}/close/',
      body: param.toJon(),
    );
    return result;
  }

  @override
  Future<GetOneBillsEntity> getOneBills(num id) async {
    var result = await getIt.get<Api>().get(endPoint: 'bill/${id}/');
    return GetOneBillsModel.fromJson(result).toEntity();
  }
}

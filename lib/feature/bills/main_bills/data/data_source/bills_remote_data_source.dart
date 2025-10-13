import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/data/model/mapper.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/entity/bills_page_entity.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/update_calculations_param.dart';
import '../../../../../core/utils/api_serviece.dart';
import '../../../../../core/utils/extract_page.dart';
import '../../domain/entity/Bills_entity.dart';
import '../../domain/entity/get_one_bills_entity.dart';
import '../../domain/use_case/param/close_bills_param.dart';
import '../../domain/use_case/param/create_bills_param.dart';
import '../../domain/use_case/param/fetch_bills_param.dart';
import '../../presentation/view/widget/apply_discount_param.dart';
import '../model/all_bills_model/get_all_bills_model.dart';
import '../model/get_one_bills_model.dart';

abstract class BillsRemoteDataSource {
  Future<BillsPageEntity> fetchBills(RequestParameters param);

  Future<GetOneBillsEntity> getOneBills(num id);

  Future<List<BillsEntity>> fetchActiveBills(RequestParameters param);

  Future<BillsEntity> createBills(CreateBillsParam param);

  Future<dynamic> closeBills(CloseBillsParam param);

  Future<dynamic> updateCalculation(UpdateCalculationsParam param);

  Future<dynamic> applyDiscount(ApplyDiscountParams param);
}

class BillsRemoteDataSourceImpl extends BillsRemoteDataSource {
  @override
  Future<BillsPageEntity> fetchBills(RequestParameters param) async {
    final url = 'bill/all?${param.toQueryParams()}';
    var result = await getIt.get<Api>().get(endPoint: url);

    List<BillsEntity> listBills = (result['results'] as List)
        .map((item) => GetAllBillsModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return BillsPageEntity(
      bills: listBills,
      nextPage: extractPage(result['next']),
      previousPage: extractPage(result['previous']),
    );
  }

  @override
  Future<BillsEntity> createBills(CreateBillsParam param) async {
    var response = await getIt.get<Api>().post(
      endPoint: 'bill/create/',
      body: param.toJson(),
    );

    return GetAllBillsModel.fromJson(response.data);
  }

  @override
  Future applyDiscount(ApplyDiscountParams param) async {
    await getIt.get<Api>().put(
      endPoint: 'bill/${param.id}/apply_discount/',
      body: param.toJson(),
    );
  }

  @override
  Future<List<BillsEntity>> fetchActiveBills(RequestParameters param) async {
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
    return await getIt.get<Api>().put(
      endPoint: 'bill/${param.id}/close/',
      body: param.toJon(),
    );
  }

  @override
  Future<GetOneBillsEntity> getOneBills(num id) async {
    var result = await getIt.get<Api>().get(endPoint: 'bill/${id}/');
    return GetOneBillsModel.fromJson(result).toEntity();
  }

  @override
  Future<dynamic> updateCalculation(UpdateCalculationsParam param) async {
    var result = await getIt.get<Api>().put(
      endPoint: 'bill/${param.id}/update_calculations/',
      body: param.toJson(),
    );

    return result.data;
  }
}

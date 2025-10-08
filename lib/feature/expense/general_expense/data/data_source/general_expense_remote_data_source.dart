import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/expense/general_expense/data/model/general_expence_mapper.dart';
import 'package:monkey_app/feature/expense/general_expense/data/model/general_expense_model.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../domain/use_case/param/update_param.dart';

abstract class GeneralExpenseRemoteDataSource {
  Future<GeneralExpenseEntity> fetchGeneralExpense(FetchBillsParam param);

  Future<GeneralExpenseItemEntity> createGeneralExpense(
    CreateExpenseParam param,
  );

  Future<GeneralExpenseItemEntity> updateGeneralExpense(
    UpdateExpenseParam param,
  );
}

class GeneralExpenseRemoteDataSourceImpl
    extends GeneralExpenseRemoteDataSource {
  @override
  Future<GeneralExpenseEntity> fetchGeneralExpense(
    FetchBillsParam param,
  ) async {
    final url = 'general_expense/all?${param.toQueryParams()}';

    var results = await getIt.get<Api>().get(endPoint: url);
    List<GeneralExpenseItemEntity> expenseItems = [];

    if (results['results'] != null) {
      for (var item in results['results']) {
        expenseItems.add(ResultsGeneralExpenseModel.fromJson(item).toEntity());
      }
    }

    final entity = GeneralExpenseEntity(
      next: results['next'] ?? '',
      previous: results['previous'] ?? '',
      results: expenseItems,
    );
    return entity;
  }

  @override
  Future<GeneralExpenseItemEntity> createGeneralExpense(
    CreateExpenseParam param,
  ) async {
    var result = await getIt.get<Api>().post(
      endPoint: 'general_expense/create/',
      body: param.toJson(),
    );
    final data = result.data;
    return ResultsGeneralExpenseModel.fromJson(data).toEntity();
  }

  @override
  Future<GeneralExpenseItemEntity> updateGeneralExpense(
    UpdateExpenseParam param,
  ) async {
    // TODO: implement updateGeneralExpense
    var result = await getIt.get<Api>().put(
      endPoint: 'general_expense/${param.id}/update/',
      body: param.toJson(),
    );
    final data = result.data;
    return ResultsGeneralExpenseModel.fromJson(data).toEntity();
  }
}

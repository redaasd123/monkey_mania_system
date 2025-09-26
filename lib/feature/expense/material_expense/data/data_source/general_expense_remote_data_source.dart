import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/material_expense/data/model/material_expense.dart';
import 'package:monkey_app/feature/expense/material_expense/data/model/material_expense_mapper.dart';
import 'package:monkey_app/feature/expense/material_expense/data/model/materlais_model.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';

import '../../../general_expense/domain/use_case/param/update_param.dart';

abstract class MaterialExpenseRemoteDataSource {
  Future<MaterialExpenseEntity> fetchMaterialExpense(FetchBillsParam param);

  Future<MaterialExpenseItemEntity> createMaterialExpense(
    CreateExpenseParam param,
  );

  Future<MaterialExpenseItemEntity> updateMaterialExpense(
    UpdateExpenseParam param,
  );

  Future<List<MaterialsEntity>> fetchMaterials(FetchBillsParam param);
}

class MaterialExpenseRemoteDataSourceImpl
    extends MaterialExpenseRemoteDataSource {
  @override
  Future<MaterialExpenseEntity> fetchMaterialExpense(
    FetchBillsParam param,
  ) async {
    var results = await getIt.get<Api>().get(
      endPoint: 'material_expense/all?${param.toQueryParams()}',
    );

    // 🟢 اطبع كل الداتا اللي راجعة
    print("📥 Full API Response: $results");

    List<MaterialExpenseItemEntity> expenseItems = [];

    for (var item in results['results']) {
      print("🔹 Single Item: $item");
      expenseItems.add(ResultsMaterialExpense.fromJson(item).toEntity());
    }

    return MaterialExpenseEntity(
      next: results['next'] ?? '',
      previous: results['previous'] ?? '',
      results: expenseItems,
    );
  }

  @override
  Future<MaterialExpenseItemEntity> createMaterialExpense(
    CreateExpenseParam param,
  ) async {
    var result = await getIt.get<Api>().post(
      endPoint: 'material_expense/create/',
      body: param.toJson(),
    );
    final data = result.data;
    return ResultsMaterialExpense.fromJson(data).toEntity();
  }

  @override
  Future<MaterialExpenseItemEntity> updateMaterialExpense(
    UpdateExpenseParam param,
  ) async {
    // TODO: implement updateGeneralExpense
    var result = await getIt.get<Api>().put(
      endPoint: 'material_expense/${param.id}/update/',
      body: param.toJson(),
    );
    final data = result.data;
    return ResultsMaterialExpense.fromJson(data).toEntity();
  }

  @override
  Future<List<MaterialsEntity>> fetchMaterials(FetchBillsParam param) async {
    final result = await getIt.get<Api>().get(
      endPoint: 'branch_material/all?${param.toQueryParams()}',
    );
    List<MaterialsEntity> data = [];
    for(var item in result){
      data.add(MaterialsModel.fromJson(item).toEntity());
    }
    return data;
  }
}

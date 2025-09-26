
import 'package:monkey_app/feature/expense/material_expense/data/model/material_expense.dart';
import 'package:monkey_app/feature/expense/material_expense/data/model/materlais_model.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';
import '../../domain/entity/material_expense_item_entity.dart';

extension GetAllMaterialExpense on MaterialExpenseModel {
  MaterialExpenseEntity toEntity() {
    return MaterialExpenseEntity(
      next: next ?? '',
      previous: previous,
      results: results?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension GetAllMaterialExpenseItem on ResultsMaterialExpense {
  MaterialExpenseItemEntity toEntity() {
    return MaterialExpenseItemEntity(
      quantity: quantity??1,
      material: material ?? "",
      unitPrice: unitPrice ?? "",
      totalPrice: totalPrice ?? '',
      id: id ?? 0,);
  }
}

extension GetAllMaterials on MaterialsModel{
  MaterialsEntity toEntity(){
    return MaterialsEntity(
        name: name??'',
        id: id??0);
  }
}


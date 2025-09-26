import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';

import '../../../general_expense/domain/use_case/param/update_param.dart';

abstract class MaterialExpenseRepo {
  Future<Either<Failure, MaterialExpenseEntity>> fetchMaterialExpense(
    FetchBillsParam param,
  );

  Future<Either<Failure, MaterialExpenseItemEntity>> createMaterialExpense(
    CreateExpenseParam param,
  );

  Future<Either<Failure, MaterialExpenseItemEntity>> updateMaterialExpense(
    UpdateExpenseParam param,
  );

  Future<Either<Failure, List<MaterialsEntity>>> fetchMaterials(
    FetchBillsParam param,
  );
}

import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/repo/material_repo.dart';

class MaterialsUseCase extends MyUseCase<List<MaterialsEntity>,FetchBillsParam>{
  final MaterialExpenseRepo repo;

  MaterialsUseCase({required this.repo});
  @override
  Future<Either<Failure, List<MaterialsEntity>>> call(FetchBillsParam param)async {
return await repo.fetchMaterials(param);
  }
}
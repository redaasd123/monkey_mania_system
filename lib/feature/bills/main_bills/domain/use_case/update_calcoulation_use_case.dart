import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/repo/bills_repo.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/update_calculations_param.dart';

class UpdateCalculationsUseCase extends MyUseCase<dynamic,UpdateCalculationsParam>{
  @override
  final BillsRepo billsRepo;

  UpdateCalculationsUseCase({required this.billsRepo});
  Future<Either<Failure, dynamic>> call(UpdateCalculationsParam param)async {
return await billsRepo.updateCalculations(param);
  }
}
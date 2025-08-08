import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/domain/repo/bills_repo.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/create_bills_param.dart';

class CreateBillsUseCase extends MyUseCase<dynamic,CreateBillsParam>{
  final BillsRepo billsRepo;

  CreateBillsUseCase({required this.billsRepo});
  @override
  Future<Either<Failure, dynamic>> call(CreateBillsParam param)async {
    // TODO: implement call
return await billsRepo.createBills(param);
  }
}
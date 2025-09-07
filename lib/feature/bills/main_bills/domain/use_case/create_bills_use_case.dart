import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../presentation/view/widget/param/create_bills_param.dart';
import '../entity/Bills_entity.dart';
import '../repo/bills_repo.dart';

class CreateBillsUseCase extends MyUseCase<BillsEntity, CreateBillsParam> {
  final BillsRepo billsRepo;

  CreateBillsUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, BillsEntity>> call(CreateBillsParam param) async {
    // TODO: implement call
    return await billsRepo.createBills(param);
  }
}

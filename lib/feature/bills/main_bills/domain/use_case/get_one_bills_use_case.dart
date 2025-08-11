import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../entity/get_one_bills_entity.dart';
import '../repo/bills_repo.dart';

class GetOneBillUseCase extends MyUseCase<GetOneBillsEntity, num> {
  final BillsRepo billsRepo;

  GetOneBillUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, GetOneBillsEntity>> call(num param) async {
    return await billsRepo.getOneBills(param);
  }
}

import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../presentation/view/widget/param/close_bills_param.dart';
import '../repo/bills_repo.dart';
class CloseBillsUseCase extends MyUseCase<dynamic, CloseBillsParam> {
  final BillsRepo billsRepo;

  CloseBillsUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, dynamic>> call(CloseBillsParam param) async {
    return await billsRepo.closeBills(param);
  }
}

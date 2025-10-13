import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../repo/bills_repo.dart';

class FetchActiveBillsUseCase extends MyUseCase<dynamic, RequestParameters> {
  final BillsRepo billsRepo;

  FetchActiveBillsUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, dynamic>> call(RequestParameters param) async {
    return await billsRepo.fetchActiveBills(param);
  }
}

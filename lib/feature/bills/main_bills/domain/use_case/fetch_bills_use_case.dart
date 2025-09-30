import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../entity/Bills_entity.dart';
import '../entity/bills_page_entity.dart';
import '../repo/bills_repo.dart';

class BillsUseCase extends MyUseCase<BillsPageEntity, FetchBillsParam> {
  final BillsRepo billsRepo;

  BillsUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, BillsPageEntity>> call(FetchBillsParam param) async {
    return await billsRepo.fetchBills(param);
  }
}

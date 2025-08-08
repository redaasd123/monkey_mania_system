import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/domain/repo/bills_repo.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/fetch_bills_param.dart';

class BillsUseCase extends MyUseCase<List<BillsEntity>, FetchBillsParam> {
  final BillsRepo billsRepo;

  BillsUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, List<BillsEntity>>> call(FetchBillsParam param) async {
    return await billsRepo.fetchBills(param);
  }
}

import 'package:dartz/dartz.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/apply_discount_param.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repo/bills_repo.dart';

class ApplyDiscountUseCase extends MyUseCase<dynamic,ApplyDiscountParams>{
  final BillsRepo billsRepo;

  ApplyDiscountUseCase({required this.billsRepo});
  @override
  Future<Either<Failure, dynamic>> call(ApplyDiscountParams param)async {
    return await billsRepo.applyDiscount(param);
  }
}
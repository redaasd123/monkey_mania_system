import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';

import '../../presentation/view/widget/apply_discount_param.dart';
import '../../presentation/view/widget/param/close_bills_param.dart';
import '../../presentation/view/widget/param/create_bills_param.dart';
import '../../presentation/view/widget/param/fetch_bills_param.dart';
import '../entity/Bills_entity.dart';
import '../entity/bills_page_entity.dart';
import '../entity/get_one_bills_entity.dart';

abstract class BillsRepo {
  Future<Either<Failure, BillsPageEntity>> fetchBills(FetchBillsParam param);

  Future<Either<Failure, BillsEntity>> createBills(CreateBillsParam param);

  Future<Either<Failure, dynamic>> applyDiscount(ApplyDiscountParams param);

  Future<Either<Failure, dynamic>> closeBills(CloseBillsParam param);

  Future<Either<Failure, List<BillsEntity>>> fetchActiveBills(
    FetchBillsParam param,
  );

  Future<Either<Failure, GetOneBillsEntity>> getOneBills(num id);
}

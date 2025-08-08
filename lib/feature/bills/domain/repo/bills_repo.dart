import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/data/model/get_all_bills_model.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/close_bills_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/create_bills_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/fetch_active_bills.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../presentation/view/widget/apply_discount_param.dart';

abstract class BillsRepo{
  Future<Either<Failure,List<BillsEntity>>> fetchBills(FetchBillsParam param);
  Future<Either<Failure,dynamic>>createBills(CreateBillsParam param);
  Future<Either<Failure,dynamic>>applyDiscount(ApplyDiscountParams param);
  Future<Either<Failure,dynamic>>closeBills(CloseBillsParam param);
  Future<Either<Failure,List<BillsEntity>>> fetchActiveBills(FetchBillsParam param);

}
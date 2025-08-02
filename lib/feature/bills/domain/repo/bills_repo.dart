import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/domain/repo/fetch_bills_param.dart';

abstract class BillsRepo{
  Future<Either<Failure,List<BillsEntity>>> fetchBills(FetchBillsPram param);
}
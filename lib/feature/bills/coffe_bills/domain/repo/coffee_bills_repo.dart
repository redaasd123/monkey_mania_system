import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';

import '../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';

abstract class CoffeeBillsRepo{
  Future<Either<Failure,List<BillsCoffeeEntity>>> fetchAllCoffeeBills(FetchBillsParam param);
  Future<Either<Failure,List<BillsCoffeeEntity>>> fetchActiveCoffeeBills(FetchBillsParam param);
  Future<Either<Failure,GetOneBillsCoffeeEntity>> getOneCoffeeBills(int id);
}
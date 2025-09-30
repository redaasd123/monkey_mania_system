import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';

import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../entity/coffee_bills_page_entity.dart';

class FetchBillsCoffeeUSeCase extends MyUseCase<BillsCoffeePageEntity,FetchBillsParam>{
  final CoffeeBillsRepo coffeeBillsRepo;

  FetchBillsCoffeeUSeCase({required this.coffeeBillsRepo});
  @override
  Future<Either<Failure, BillsCoffeePageEntity>> call(FetchBillsParam param) async{
return await  coffeeBillsRepo.fetchAllCoffeeBills(param);
  }

}
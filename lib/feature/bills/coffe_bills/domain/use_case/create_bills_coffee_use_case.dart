import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';

import '../repo/coffee_bills_repo.dart';

class CreateBillsCoffeeUSeCase extends MyUseCase<Unit,CreateBillsPCoffeeParam>{
  final CoffeeBillsRepo billsRepo;

  CreateBillsCoffeeUSeCase({required this.billsRepo});

  @override
  Future<Either<Failure, Unit>> call(CreateBillsPCoffeeParam param) async{
    return await billsRepo.createCoffeeBills(param);
  }



}
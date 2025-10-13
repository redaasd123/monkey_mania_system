import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/param/return_product_param.dart';

class ReturnProductsUseCase extends MyUseCase<BillsCoffeeEntity,ReturnProductsParam>{
  @override
  final CoffeeBillsRepo coffeeBillsRepo;

  ReturnProductsUseCase({required this.coffeeBillsRepo});
  Future<Either<Failure, BillsCoffeeEntity>> call(ReturnProductsParam param)async {
    return await coffeeBillsRepo.returnProduct(param);


  }
}
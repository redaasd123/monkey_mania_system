import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';

class GetOneCoffeeBillsUseCase extends MyUseCase<GetOneBillsCoffeeEntity,int>{
  final CoffeeBillsRepo coffeeBillsRepo;

  GetOneCoffeeBillsUseCase({required this.coffeeBillsRepo});
  @override
  Future<Either<Failure, GetOneBillsCoffeeEntity>> call(int param) async{
return await coffeeBillsRepo.getOneCoffeeBills(param);
  }
}
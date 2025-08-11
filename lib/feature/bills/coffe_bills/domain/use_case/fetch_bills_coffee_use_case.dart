import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

class FetchBillsCoffeeUSeCase extends MyUseCase<List<BillsCoffeeEntity>,FetchBillsParam>{
  final CoffeeBillsRepo coffeeBillsRepo;

  FetchBillsCoffeeUSeCase({required this.coffeeBillsRepo});
  @override
  Future<Either<Failure, List<BillsCoffeeEntity>>> call(FetchBillsParam param) async{
return await  coffeeBillsRepo.fetchAllCoffeeBills(param);
  }

}
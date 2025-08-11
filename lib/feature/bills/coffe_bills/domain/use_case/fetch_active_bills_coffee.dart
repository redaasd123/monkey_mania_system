import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../entity/bills_coffee_entity.dart';
import '../repo/coffee_bills_repo.dart';

class FetchActiveBillsCoffeeUSeCase extends MyUseCase<List<BillsCoffeeEntity>,FetchBillsParam>{
  final CoffeeBillsRepo coffeeBillsRepo;

  FetchActiveBillsCoffeeUSeCase({required this.coffeeBillsRepo});
  @override
  Future<Either<Failure, List<BillsCoffeeEntity>>> call(FetchBillsParam param) async{
    return await  coffeeBillsRepo.fetchActiveCoffeeBills(param);
  }

}
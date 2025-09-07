import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

class GetLayerOneUseCase extends MyUseCase<List<LayersEntity>, FetchBillsParam> {
  final CoffeeBillsRepo billsRepo;

  GetLayerOneUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, List<LayersEntity>>> call(FetchBillsParam param)async {
    return await billsRepo.getLayerOne(param);

  }


}

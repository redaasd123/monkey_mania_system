import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
class GetLayerTowUseCase extends MyUseCase<List<LayersEntity>,RequestParameters>{
  final CoffeeBillsRepo billsRepo;

  GetLayerTowUseCase({required this.billsRepo});

  @override
  Future<Either<Failure, List<LayersEntity>>> call(RequestParameters param) async{
    return await billsRepo.getLayerTow(param);
  }

}

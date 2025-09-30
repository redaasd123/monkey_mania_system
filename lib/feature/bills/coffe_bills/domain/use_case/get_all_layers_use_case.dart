import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
class GetAllLayersUseCase extends MyUseCase<List<GetAllLayerEntity>,FetchBillsParam> {
  @override
  final CoffeeBillsRepo coffeeBillsRepo;

  GetAllLayersUseCase({required this.coffeeBillsRepo});

  @override
  Future<Either<Failure, List<GetAllLayerEntity>>> call(FetchBillsParam param)async {
return await coffeeBillsRepo.getAllLayers(param);
  }

}

import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';
import 'package:monkey_app/feature/home/domain/repo/home_repo.dart';

class HomeUseCase extends MyUseCase<HomeEntity,FetchBillsParam>{
  final HomeRepo homeRepo;

  HomeUseCase({required this.homeRepo});
  @override
  Future<Either<Failure,HomeEntity>> call(FetchBillsParam param)async {
return await  homeRepo.fetchDashBoardData(param);
  }
}
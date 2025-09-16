import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';

import '../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

abstract class HomeRepo{
 Future<Either<Failure,HomeEntity>>fetchDashBoardData(FetchBillsParam param);
}
import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';

abstract class HomeRepo{
 Future<Either<Failure,HomeEntity>>fetchDashBoardData();
}
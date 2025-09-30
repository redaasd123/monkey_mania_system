import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/csv_analytics/domain/entity/analytic_type_entity.dart';

abstract class AnalyticRepo {
  Future<Either<Failure,List<AnalyticTypeEntity>>>fetchAnalyticType();
}
import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/csv_analytics/domain/entity/analytic_type_entity.dart';
import 'package:monkey_app/feature/csv_analytics/domain/repo/analytic_repo.dart';

class AnalyticTypeUseCase extends MyUseCase<List<AnalyticTypeEntity>, NoParam> {
  final AnalyticRepo repo;

  AnalyticTypeUseCase({required this.repo});

  @override
  Future<Either<Failure, List<AnalyticTypeEntity>>> call(NoParam param) async {
    return await repo.fetchAnalyticType();
  }
}

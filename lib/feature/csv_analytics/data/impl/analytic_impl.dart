import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/csv_analytics/data/model/analytic_type_model.dart';
import 'package:monkey_app/feature/csv_analytics/data/model/mapper.dart';
import 'package:monkey_app/feature/csv_analytics/domain/entity/analytic_type_entity.dart';
import 'package:monkey_app/feature/csv_analytics/domain/repo/analytic_repo.dart';

class AnalyticTypeImpl extends AnalyticRepo {
  @override
  Future<Either<Failure, List<AnalyticTypeEntity>>> fetchAnalyticType() async {
    try {
      var result = await getIt.get<Api>().get(
        endPoint: 'csv_analytics/allowed_types/',
      );
      List<AnalyticTypeEntity> data = [];
      for (var item in result) {
        data.add(AnalyticTypeModel.fromJson(item).toEntity());
      }
      return right(data);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}

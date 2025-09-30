import 'package:monkey_app/feature/csv_analytics/data/model/analytic_type_model.dart';
import 'package:monkey_app/feature/csv_analytics/domain/entity/analytic_type_entity.dart';

extension GetAnalyticType on AnalyticTypeModel {
  AnalyticTypeEntity toEntity() {
    return AnalyticTypeEntity(name: name);
  }
}

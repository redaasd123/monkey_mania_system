import 'package:monkey_app/feature/children/data/model/children_non_active_model.dart';
import 'package:monkey_app/feature/children/domain/entity/children/non_active.dart';

extension GetNonActiveChildren on ChildrenNonActiveModel {
  ChildrenNonActiveEntity toEntity() {
    return ChildrenNonActiveEntity(name: name ?? "", id: id ?? 0);
  }
}

import 'package:hive/hive.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/hive_entity/layers_hive_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/school/domain/entity/school_entity.dart';

void saveChildrenData(List<ChildrenEntity> data, String boxName) {
  var box = Hive.box<ChildrenEntity>(boxName);
  box.clear();
  box.addAll(data);
}

void saveSchoolData(List<SchoolEntity> data, String boxName) {
  var box = Hive.box<SchoolEntity>(boxName);
  box.clear();
  box.addAll(data);
}

void saveLayers(List<LayersHiveEntity> data, String boxName) {
  var box = Hive.box<LayersHiveEntity>(boxName);
  // box.clear();
  box.addAll(data);
}

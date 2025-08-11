import 'package:hive/hive.dart';
import 'package:monkey_app/core/utils/constans.dart';

import '../../domain/entity/school_entity.dart';

abstract class SchoolLocalDataSource {
  List<SchoolEntity> fetchSchools();
}

class SchoolLocalDataSourceImpl extends SchoolLocalDataSource {
  @override
  List<SchoolEntity> fetchSchools() {
    final box = Hive.box<SchoolEntity>(kSchoolBox);
    return box.values.toList();
  }
}

import 'package:hive/hive.dart';
import 'package:monkey_app/core/utils/constans.dart';

import '../../domain/entity/children/children_entity.dart';

abstract class ChildrenLocalDataSource{

 List<ChildrenEntity> fetchChildren();
}

class ChildrenLocalDataSourceImpl extends ChildrenLocalDataSource{
  @override
  List<ChildrenEntity> fetchChildren() {
  final box = Hive.box<ChildrenEntity>(kChildrenBox);
  return box.values.toList();
  }
}
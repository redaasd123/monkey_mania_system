import 'package:hive/hive.dart';
import 'package:monkey_app/feature/children/domain/param/fetch_children_param.dart';

import '../../../../core/utils/constans.dart';
import '../../domain/entity/children/children_entity.dart';
import '../../domain/entity/children/children_page_entity.dart';

abstract class ChildrenLocalDataSource {
  /// يرجع قائمة من ChildrenEntities حسب الصفحة المطلوبة
  ChildrenPageEntity fetchChildren(FetchChildrenParam? param);
}

class ChildrenLocalDataSourceImpl extends ChildrenLocalDataSource {
  @override
  ChildrenPageEntity fetchChildren(FetchChildrenParam? param) {
    final box = Hive.box<ChildrenEntity>(kChildrenBox);
    final allChildren = box.values.toList();

    // لو param == null خلي الصفحة 1 بشكل افتراضي
    final pageNumber = param?.pageNumber ?? 1;
    const pageSize = 10;

    final startIndex = (pageNumber - 1) * pageSize;

    if (startIndex >= allChildren.length) {
      return ChildrenPageEntity(nextPage: 0, children: []);
    }

    final endIndex = (startIndex + pageSize).clamp(0, allChildren.length);
    final pageItems = allChildren.sublist(startIndex, endIndex);

    final nextPage = endIndex < allChildren.length ? pageNumber + 1 : 0;

    return ChildrenPageEntity(
      children: pageItems,
      nextPage: nextPage,
    );
  }
}

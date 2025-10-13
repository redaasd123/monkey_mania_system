import 'package:monkey_app/core/utils/api_serviece.dart';

import '../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../core/param/update_children_param/update_children_param.dart';
import '../../../../core/utils/extract_page.dart';
import '../../../../core/utils/service_locator.dart';
import '../../domain/entity/children/children_entity.dart';
import '../../domain/entity/children/children_page_entity.dart';
import '../../domain/param/fetch_children_param.dart';
import '../model/children_model.dart';

abstract class ChildrenRemoteDataSource {
  Future<ChildrenPageEntity> fetchChildren(FetchChildrenParam? param);

  Future<ChildrenEntity> updateChildren(UpdateChildrenParam param);

  Future<ChildrenEntity> createChildren(CreateChildrenParam param);
}

class ChildrenRemoteDataSourceImpl extends ChildrenRemoteDataSource {
  ChildrenRemoteDataSourceImpl();

  @override
  Future<ChildrenPageEntity> fetchChildren(FetchChildrenParam? param) async {
    Map<String, dynamic> result = await getIt.get<Api>().get(
      endPoint: 'child/all/',
      queryParameters: param?.toJson(),
    );

    List<ChildrenEntity> childrenList = [];
    if (result['results'] != null) {
      for (var item in result['results']) {
        final child = ChildrenModel.fromJson(item);
        childrenList.add(child);
      }
    }

    final entity = ChildrenPageEntity(
      nextPage: extractPage(result['next']),
      children: childrenList,
    );

    return entity;
  }

  @override
  Future<ChildrenEntity> updateChildren(UpdateChildrenParam param) async {
    var response = await getIt.get<Api>().put(
      endPoint: 'child/${param.id}/update/',
      body: param.toJson(),
    );
    final data = response.data;
    return ChildrenModel.fromJson(data);
  }

  @override
  Future<ChildrenEntity> createChildren(CreateChildrenParam param) async {
    final response = await getIt.get<Api>().post(
      endPoint: "child/create/",
      body: param.toJson(),
    );
    final data = response.data;
    return ChildrenModel.fromJson(data);
  }
}

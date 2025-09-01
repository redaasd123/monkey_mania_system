import 'package:monkey_app/core/utils/api_serviece.dart';

import '../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../core/param/update_children_param/update_children_param.dart';
import '../../../../core/utils/constans.dart';
import '../../../../core/utils/save_data.dart';
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
  //final Api api;

  ChildrenRemoteDataSourceImpl();

  @override
  Future<ChildrenPageEntity> fetchChildren(FetchChildrenParam? param) async {
    print('📌 Sending request for page: $param');

    Map<String, dynamic> result = await getIt.get<Api>().get(
      endPoint: 'child/all/',
      queryParameters: param?.toJson(),
    );

    // طباعة بيانات الرد
    print('✅ Response status received');
    print('📦 Response data count: ${result['count']}');
    print('📦 Next page URL: ${result['next']}');
    print('📦 Previous page URL: ${result['previous']}');

    List<ChildrenEntity> childrenList = [];
    for (var item in result['results']) {
      childrenList.add(ChildrenModel.fromJson(item));
    }

    print('📥 Fetched ${childrenList.length} children from API');

    saveChildrenData(childrenList, kChildrenBox);

    int? extractPage(String? url) {
      if (url == null) return null;
      final uri = Uri.parse(url);
      return int.tryParse(uri.queryParameters['page'] ?? '');
    }

    return ChildrenPageEntity(
      nextPage: extractPage(result['next']),
      children: childrenList,
    );
  }

  @override
  Future<ChildrenEntity> updateChildren(UpdateChildrenParam param) async {
    print('📤 PUT BODY: ${param.toJson()}');
    print("${param.toJson()}😽😽😽😽😽😽👄👄👄");
    var response = await getIt.get<Api>().put(
      endPoint: 'child/${param.id}/update/',
      body: param.toJson(),
    );
    final data = response.data;
    return ChildrenModel.fromJson(data);
  }

  @override
  Future<ChildrenEntity> createChildren(CreateChildrenParam param) async {
    print('🧒 DATA FROM SHEET: $param');
    print('🧒 JSON: ${param.toJson()}');
    final response = await getIt.get<Api>().post(
      endPoint: "child/create/",
      body: param.toJson(),
    );
    final data = response.data;
    return ChildrenModel.fromJson(data);
  }
}

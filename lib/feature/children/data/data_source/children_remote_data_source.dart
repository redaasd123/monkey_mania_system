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

  ChildrenRemoteDataSourceImpl();

  @override
  Future<ChildrenPageEntity> fetchChildren(FetchChildrenParam? param) async {
    try {
      print('🚀 Sending request for children list');
      print('📌 Request param: $param');
      print('📌 Request queryParams: ${param?.toJson()}');

      Map<String, dynamic> result = await getIt.get<Api>().get(
        endPoint: 'child/all/',
        queryParameters: param?.toJson(),
      );

      // 🟢 اطبع الريسبونس كامل
      print('✅ Response received from API');
      print('📦 Full Response: $result');

      // طباعة بيانات عامة
      print('📦 Response count: ${result['count']}');
      print('📦 Next page URL: ${result['next']}');
      print('📦 Previous page URL: ${result['previous']}');

      List<ChildrenEntity> childrenList = [];
      if (result['results'] != null) {
        for (var item in result['results']) {
          print('🔹 Raw child item: $item'); // قبل التحويل
          final child = ChildrenModel.fromJson(item);
          print('✅ Parsed child entity: $child'); // بعد التحويل
          childrenList.add(child);
        }
      } else {
        print('⚠️ No results found in response');
      }

      print('📥 Total children parsed: ${childrenList.length}');

      // احفظ البيانات في Hive
      saveChildrenData(childrenList, kChildrenBox);

      int? extractPage(String? url) {
        if (url == null) return null;
        final uri = Uri.parse(url);
        return int.tryParse(uri.queryParameters['page'] ?? '');
      }

      final entity = ChildrenPageEntity(
        nextPage: extractPage(result['next']),
        children: childrenList,
      );

      print('🎯 Final ChildrenPageEntity: $entity');
      return entity;
    } catch (e, st) {
      print('❌ Error while fetching children: $e');
      print('🛠️ StackTrace: $st');
      rethrow;
    }
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

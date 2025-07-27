import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/initialize_Sync_Services.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/save_data.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/funcation/show_snack_bar.dart';
import '../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../core/param/update_children_param/update_children_param.dart';
import '../../domain/entity/children/children_entity.dart';

abstract class ChildrenRemoteDataSource {
  Future<List<ChildrenEntity>> fetchChildren();

  Future<dynamic> updateChildren(UpdateChildrenParam param);

  Future<dynamic> createChildren(CreateChildrenParam param);
}

class ChildrenRemoteDataSourceImpl extends ChildrenRemoteDataSource {
  //final Api api;

  ChildrenRemoteDataSourceImpl();

  @override
  Future<List<ChildrenEntity>> fetchChildren() async {
    List<dynamic> result = await getIt.get<Api>().get(
      endPoint: 'child/non_active/all/',
    );
    List<ChildrenEntity> childrenList = [];
    for (var item in result) {
      childrenList.add(ChildrenModel.fromJson(item));
    }
    saveChildrenData(childrenList, kChildrenBox);
    return childrenList;
  }

  @override
  Future updateChildren(UpdateChildrenParam param) async {
    print("${param.tojson()}😽😽😽😽😽😽👄👄👄");
    var response = await getIt.get<Api>().put(
      endPoint: 'child/${param.id}/update/',
      body: param.tojson(),
    );
    return response;
  }

  @override
  Future createChildren(CreateChildrenParam param) async {
    print('🧒 DATA FROM SHEET: $param');
    print('🧒 JSON: ${param.toJson()}');
    final response = await getIt.get<Api>().post(
      endPoint: "child/create/",
      body: param.toJson(),
    );
    return response;
  }
}

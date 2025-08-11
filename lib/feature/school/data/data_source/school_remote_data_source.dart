import 'package:dio/dio.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/save_data.dart';
import 'package:monkey_app/feature/school/domain/entity/school_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/param/create_school_param/create_school_param.dart';
import '../../../../core/param/update_school_param/update_school_param.dart';
import '../model/school_model.dart';

abstract class SchoolRemoteDataSource {
  Future<List<SchoolEntity>> fetchSchools();

  Future<SchoolModel> createSchool(CreateSchoolParam param);

  Future<SchoolModel> updateSchool(UpdateSchoolParam param);
}

class SchoolRemoteDataSourceImpl extends SchoolRemoteDataSource {
  final Api api;

  SchoolRemoteDataSourceImpl({required this.api});

  @override
  Future<List<SchoolEntity>> fetchSchools() async {
    List<dynamic> data = await api.get(endPoint: 'school/all/');
    List<SchoolEntity> school = [];
    for (var item in data) {
      school.add(SchoolModel.fromJson(item));
    }
    saveSchoolData(school, kSchoolBox);
    return school;
  }

  @override
  Future<SchoolModel> createSchool(CreateSchoolParam param) async {
    try {
      final response = await api.post(
        endPoint: 'school/create/',

        body: param.toJson(),
      );

      final data = response.data; //
      if (data is Map<String, dynamic>) {
        return SchoolModel.fromJson(data);
      } else {
        throw ServerFailure(errMessage: 'Unexpected response format');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(errMessage: e.toString());
    }

    // }
  }

  @override
  Future<SchoolModel> updateSchool(UpdateSchoolParam param) async {
    try {
      final response = await api.put(
        endPoint: 'school/${param.id}/update/',

        body: param.toJson(),
      );
      final data = response.data; //
      if (data is Map<String, dynamic>) {
        return SchoolModel.fromJson(data);
      } else {
        throw ServerFailure(errMessage: 'Unexpected response format');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(errMessage: e.toString());
    }
  }
}

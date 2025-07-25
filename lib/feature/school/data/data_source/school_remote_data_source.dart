import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/save_data.dart';
import 'package:monkey_app/feature/school/domain/entity/school_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/helper/auth_helper.dart';
import '../model/school_model.dart';

abstract class SchoolRemoteDataSource{

  Future<List<SchoolEntity>> fetchSchools();
  Future<SchoolModel> postSchool({required String name,required String address, String? notes});
  Future<SchoolModel> updateSchool({required int id,required String name,required String address, String? notes});

}

class SchoolRemoteDataSourceImpl extends SchoolRemoteDataSource{
  final Api api;

  SchoolRemoteDataSourceImpl({required this.api});
  @override
  Future<List<SchoolEntity>> fetchSchools()async {
    List<dynamic> data = await api.get(endPoint: 'school/all/');
    List<SchoolEntity> school =[];
    for(var item in data){
      school.add(SchoolModel.fromJson(item));
    }
   saveSchoolData(school, kSchoolBox);
    return school;
  }
  @override
  Future<SchoolModel> postSchool({
    required String name,
    required String address,
    String? notes,
  }) async {


    try {
      final response = await api.post(
        endPoint: 'school/create/',

        body: {
          'name': name,
          'address': address,
          if (notes != null && notes.trim().isNotEmpty) 'notes': notes,
        },
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
  Future<SchoolModel> updateSchool({required int id,required String name, required String address, String? notes})async {
    final token = AuthHelper.getAccessToken();
    if (token == null) {
      throw ServerFailure(errMessage: 'No access token');
    }

    try {
      final response = await api.put(
        endPoint: 'school/$id/update/',

        body: {
          'name': name,
          'address': address,
          if (notes != null && notes.trim().isNotEmpty) 'notes': notes,
        },
      );
      print('🔍🔍🔍🔗 endpoint: school/$id/update/');

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
  }}
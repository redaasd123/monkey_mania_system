import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/save_data.dart';
import 'package:monkey_app/feature/school/data/data_source/school_local_data_source.dart';
import 'package:monkey_app/feature/school/domain/entity/school_entity.dart';

import '../../domain/repo/school_repo.dart';
import '../data_source/school_remote_data_source.dart';
import '../model/school_model.dart';

class SchoolRepoImpl implements SchoolRepo {
  final SchoolRemoteDataSource schoolRemoteDataSource;
  final SchoolLocalDataSource schoolLocalDataSource;

  SchoolRepoImpl(
    this.schoolLocalDataSource, {
    required this.schoolRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<SchoolEntity>>> fetchSchools() async {
    try {
      final box = await schoolLocalDataSource.fetchSchools();
      if (box != null && box.isNotEmpty) {
        return right(box);
      }
      final schools = await schoolRemoteDataSource.fetchSchools();
      return Right(schools);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SchoolModel>> postSchool({
    required String name,
    required String address,
    String? notes,
  }) async {
    try {
      var result = await schoolRemoteDataSource.postSchool(
        name: name,
        address: address,
        notes: notes,
      );
      final list =await schoolRemoteDataSource.fetchSchools();
       saveSchoolData(list, kSchoolBox);

      return right(result);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on Failure catch (f) {
      // ✅ يلتقط ServerFailure هنا
      return Left(f);
    } catch (e) {
      // أي خطأ غير متوقَّع
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SchoolModel>> updateSchool({
    required int id,
    required String name,
    required String address,
    String? notes,
  }) async {
    try {
      var result = await schoolRemoteDataSource.updateSchool(
        name: name,
        address: address,
        notes: notes,
        id: id,
      );
      final list =await schoolRemoteDataSource.fetchSchools();
      saveSchoolData(list, kSchoolBox);
      return right(result);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on Failure catch (f) {
      // ✅ يلتقط ServerFailure هنا
      return Left(f);
    } catch (e) {
      // أي خطأ غير متوقَّع
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}

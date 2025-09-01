import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/errors/off_line_failure.dart';
import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';
import 'package:monkey_app/core/param/update_school_param/update_school_param.dart';
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
  Future<Either<Failure, List<SchoolEntity>>> fetchSchools(String? query) async {
    try {
      final box = await schoolLocalDataSource.fetchSchools();
      if (box != null && box.isNotEmpty) {
        unawaited(_fetchAndCacheFromServer());
        return right(box);
      }
      final schools = await schoolRemoteDataSource.fetchSchools(query??'');
      return Right(schools);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  Future<void> _fetchAndCacheFromServer() async {
    try {
      final data = await schoolRemoteDataSource.fetchSchools('');
      saveSchoolData(data, kSchoolBox);
      // تقدر تبعت Signal للـ Cubit لو حبيت تحدث الشاشة
    } catch (_) {
      // تجاهل الأخطاء هنا لو كان تحديث خلفي
    }
  }

  @override
  Future<Either<Failure, SchoolEntity>> createSchool(
    CreateSchoolParam param,
  ) async {
    final isConnected = await checkInternet();
    print('🌐 INTERNET STATUS: $isConnected');
    print('🧒 CHILD PARAM TO SAVE OR SEND: ${param.toJson()}');
    final box = Hive.box<CreateSchoolParam>(kSaveCreateSchool);
    if (isConnected) {
      try {
        var result = await schoolRemoteDataSource.createSchool(param);
        print('✅ school CREATED SUCCESSFULLY');
        final list = await schoolRemoteDataSource.fetchSchools('');
        saveSchoolData(list, kSchoolBox);
        return right(result);
      } on DioException catch (e) {
        print('❌ DIO ERROR OCCURRED. SAVING TO HIVE.');
        print('📦 SAVING CHILD TO HIVE: ${param.toJson()}');
        return Left(ServerFailure.fromDioError(e));
      } on Failure catch (f) {
        return Left(f);
      } catch (e) {
        print('❌ UNKNOWN ERROR: ${e.toString()}');
        box.add(param);
        return Left(ServerFailure(errMessage: e.toString()));
      }
    } else {
      print('⚠️ NO INTERNET. SAVING TO HIVE.');
      print('📦 SAVING CHILD TO HIVE: ${param.toJson()}');
      box.add(param);
      return left(
        OfflineFailure(
          errMessage:
              'لم يتوفر اتصال بالإنترنت وتم الحفظ مؤقتاً، وسيتم الإرسال تلقائياً عند توفر الاتصال. قد يستغرق هذا الأمر بضع دقائق.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SchoolEntity>> updateSchool(
    UpdateSchoolParam param,
  ) async {
    final isConnected = await checkInternet();
    print('🌐 INTERNET STATUS: $isConnected');
    print('🧒 CHILD PARAM TO SAVE OR SEND: ${param.toJson()}');
    final box = Hive.box<UpdateSchoolParam>(kSaveUpdateSchool);
    if (isConnected) {
      try {
        var result = await schoolRemoteDataSource.updateSchool(param);
        print('✅ school CREATED SUCCESSFULLY');
        final list = await schoolRemoteDataSource.fetchSchools('');
        saveSchoolData(list, kSchoolBox);
        return right(result);
      } on DioException catch (e) {
        print('❌ DIO ERROR OCCURRED. SAVING TO HIVE.');
        print('📦 SAVING CHILD TO HIVE: ${param.toJson()}');
        box.add(param);
        return Left(ServerFailure.fromDioError(e));
      } on Failure catch (f) {
        box.add(param);
        return Left(f);
      } catch (e) {
        print('❌ UNKNOWN ERROR: ${e.toString()}');
        box.add(param);
        return Left(ServerFailure(errMessage: e.toString()));
      }
    } else {
      print('⚠️ NO INTERNET. SAVING TO HIVE.');
      print('📦 SAVING CHILD TO HIVE: ${param.toJson()}');
      box.add(param);
      return left(
        OfflineFailure(
          errMessage:
              'لم يتوفر اتصال بالإنترنت وتم الحفظ مؤقتاً، وسيتم الإرسال تلقائياً عند توفر الاتصال. قد يستغرق هذا الأمر بضع دقائق.',
        ),
      );
    }
  }

  Future<bool> checkInternet() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false; // لا يوجد اتصال بالإنترنت
    }
    return true; // يوجد اتصال بالإنترنت
  }
}

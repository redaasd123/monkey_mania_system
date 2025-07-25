import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/errors/off_line_failure.dart' hide Failure;
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/save_data.dart';
import 'package:monkey_app/feature/children/data/data_source/children_remote_data_source.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';

import '../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../core/param/update_children_param/update_children_param.dart';
import '../../domain/entity/children/children_entity.dart';
import '../data_source/childern_local_data_source.dart';

class ChildrenRepoImpl extends ChildrenRepo {
  final ChildrenRemoteDataSource childrenRemoteDataSource;
  final ChildrenLocalDataSource childrenLocalDataSource;

  ChildrenRepoImpl(
    this.childrenLocalDataSource, {
    required this.childrenRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<ChildrenEntity>>> fetchChildren() async {
    try {
      final localChildren = await childrenLocalDataSource.fetchChildren();

      if (localChildren != null && localChildren.isNotEmpty) {
        unawaited(_fetchAndCacheFromServer()); // ← تحديث صامت في الخلفية
        return right(localChildren);
      }

      // ✅ لو مفيش كاش من البداية
      final result = await childrenRemoteDataSource.fetchChildren();
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  Future<void> _fetchAndCacheFromServer() async {
    try {
      final freshData = await childrenRemoteDataSource.fetchChildren();
      saveChildrenData(freshData, kChildrenBox);
      // تقدر تبعت Signal للـ Cubit لو حبيت تحدث الشاشة
    } catch (_) {
      // تجاهل الأخطاء هنا لو كان تحديث خلفي
    }
  }

  @override
  Future<Either<Failure, dynamic>> createChildren(
    CreateChildrenParam param,
  ) async {
    final box = Hive.box<CreateChildrenParam>(kSaveCreateChild);

    final isConnected = await checkInternet();
    print('🌐 INTERNET STATUS: $isConnected');
    print('🧒 CHILD PARAM TO SAVE OR SEND: ${param.toJson()}');

    if (isConnected) {
      try {
        var result = await childrenRemoteDataSource.createChildren(param);
        print('✅ CHILD CREATED SUCCESSFULLY');

        final updatedList = await childrenRemoteDataSource.fetchChildren();
        saveChildrenData(updatedList, kChildrenBox);
        return right(result);
      } on Exception catch (e) {
        if (e is DioException) {
          print('❌ DIO ERROR OCCURRED. SAVING TO HIVE.');
          print('📦 SAVING CHILD TO HIVE: ${param.toJson()}');
          box.add(param);
          return left(ServerFailure.fromDioError(e));
        } else {
          box.add(param);
          print('❌ UNKNOWN ERROR: ${e.toString()}');
          return left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      print('⚠️ NO INTERNET. SAVING TO HIVE.');
      print('📦 SAVING CHILD TO HIVE: ${param.toJson()}');
      box.add(param);
      return left(OfflineFailure(errMessage: 'لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateChildren(
    UpdateChildrenParam param,
  ) async {
    final box = Hive.box<UpdateChildrenParam>(kSaveUpdateChild);
    final isConnected = await checkInternet();
    if (isConnected) {
      try {
        var result = await childrenRemoteDataSource.updateChildren(param);
        final updatedList = await childrenRemoteDataSource.fetchChildren();
        saveChildrenData(updatedList, kChildrenBox);
        return right(result);
      } on Exception catch (e) {
        if (e is DioException) {
          box.add(param);
          return left(ServerFailure.fromDioError(e));
        } else {
          return left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      box.add(param);
      return left(OfflineFailure(errMessage: 'لا يوجد اتصال بالانترنت '));
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

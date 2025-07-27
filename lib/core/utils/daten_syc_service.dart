import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'api_serviece.dart';


//ده بيخلق نوع بيانات جديد اسمه HttpMethod وله قيمتين فقط: HttpMethod.post و HttpMethod.put
enum HttpMethod  {post, put}
class DataSyncService<T> {
  final String boxName;
  final String? endPoint;
  final String Function(T param)? endpointBuilder;
  final Map<String, dynamic> Function(T) toJson;
  final void Function()? onSuccess;
  final HttpMethod method ;

  DataSyncService({
    required this.method,
     this.endpointBuilder,
    required this.boxName,
    this.endPoint,
    required this.toJson,
    this.onSuccess,
  });

  Future<void> resendSavedData() async {
    final connectivity = await Connectivity().checkConnectivity();
    final hasInternet = connectivity != ConnectivityResult.none;

    if (!hasInternet) return;

    final box = await Hive.openBox<T>(boxName);
    final keys = box.keys.toList();

    for (var key in keys) {
      final item = box.get(key);
      if (item != null) {
        try {
          // ✅ حدد الـ endpoint بناءً على الـ item الحالي
          final endpoint = endpointBuilder != null
              ? endpointBuilder!(item)
              : endPoint!;

          if(method ==HttpMethod.post){
            await getIt.get<Api>().post(
              endPoint: endpoint,
              body: toJson(item),
            );
          }else{
            await getIt.get<Api>().put(
              endPoint: endpoint,
              body: toJson(item),
            );
          }


          await box.delete(key);
        } catch (e) {
          // Handle retry logic or logging if needed
        }
      }
    }

    onSuccess?.call();
  }
}






import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';
import 'package:monkey_app/core/param/update_children_param/update_children_param.dart';
import 'package:monkey_app/core/param/update_school_param/update_school_param.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import '../param/create_children_params/create_children_params.dart';
import 'constans.dart';
import 'contivity.dart';
import 'daten_syc_service.dart';

Future<void> initializeSyncServices() async {
  final resend = () async {
    /// ✅ Create
    await DataSyncService<CreateChildrenParam>(
      method:  HttpMethod.post,
      endPoint: 'child/create/',
      boxName: kSaveCreateChild,
      toJson: (param) => param.toJson(),
      onSuccess: () {
        print("🔥 Create syncing finished. Calling fetchChildren...");
      },
    ).resendSavedData();

    /// ✅ Update
    await DataSyncService<UpdateChildrenParam>(
      method: HttpMethod.put,
      boxName: kSaveUpdateChild,
      endpointBuilder: (param) => 'child/${param.id}/update/',
      toJson:  (param) => param.tojson(),
      onSuccess: () {
        print("🔥 Update syncing finished. Calling fetchChildren...");
      },
    ).resendSavedData();

    await DataSyncService<CreateSchoolParam>(
      method: HttpMethod.post,
      boxName: kSaveCreateSchool,
      endPoint: 'school/create/',
      toJson: (param)=>param.toJson(),
      onSuccess: (){
        print("🔥 Create syncing finished. Calling fetchSchool...");
      }
    ).resendSavedData();

    await DataSyncService<UpdateSchoolParam>(
      method: HttpMethod.put,
      boxName: kSaveUpdateSchool,
      endpointBuilder: (param)=>'school/${param.id}/update/',
      toJson: (param)=>param.toJson(),
      onSuccess: (){
        print("🔥 Update syncing finished. Calling fetchSchool...");
      }
    ).resendSavedData();
  };

  await resend();
  ConnectivityService().startMonitoring(resend);
}

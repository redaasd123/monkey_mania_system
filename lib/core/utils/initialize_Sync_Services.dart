import 'package:monkey_app/core/param/update_children_param/update_children_param.dart';
import 'package:monkey_app/core/utils/service_locator.dart';

import '../../feature/children/presentation/manager/cubit/children_cubit.dart';
import '../param/create_children_params/create_children_params.dart';
import 'constans.dart';
import 'contivity.dart';
import 'daten_syc_service.dart';

Future<void> initializeSyncServices() async {
  final resend = () async {
    /// ✅ Create
    await DataSyncService<CreateChildrenParam>(
      endPoint: 'child/create/',
      boxName: kSaveCreateChild,
      toJson: (param) => param.toJson(),
      onSuccess: () {
        print("🔥 Create syncing finished. Calling fetchChildren...");
      },
    ).resendSavedData();

    /// ✅ Update
    await DataSyncService<UpdateChildrenParam>(
      boxName: kSaveUpdateChild,
      endpointBuilder: (param) => 'child/${param.id}/update/',
      toJson: (param) => param.tojson(),
      onSuccess: () {
        print("🔥 Update syncing finished. Calling fetchChildren...");
      },
    ).resendSavedData();
  };

  await resend();
  ConnectivityService().startMonitoring(resend);
}

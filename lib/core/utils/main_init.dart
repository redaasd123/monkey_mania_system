import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monkey_app/core/param/create_children_params/create_children_params.dart';
import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';
import 'package:monkey_app/core/param/update_children_param/update_children_param.dart';
import 'package:monkey_app/core/param/update_school_param/update_school_param.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/children/domain/entity/age/age_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/phone/phone_entity.dart';
import 'package:monkey_app/feature/school/domain/entity/school_entity.dart';
import '../../main.dart';
import 'constans.dart';
import 'initialize_Sync_Services.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class AppInitializer {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    _registerHiveAdapters();
    await _initHive();
    //
    // await Hive.deleteBoxFromDisk(kSchoolBox);
    // await Hive.deleteBoxFromDisk(kChildrenBox);
    // await Hive.deleteBoxFromDisk(kSaveCreateChild);

    await _openHiveBoxes();

    setUpServiceLocator();
    await initializeSyncServices();
  }

  static Widget buildApp() {
    return EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MonkeyApp(),
    );
  }

  static void _registerHiveAdapters() {
    Hive.registerAdapter(SchoolEntityAdapter());
    Hive.registerAdapter(ChildrenEntityAdapter());
    Hive.registerAdapter(AgeEntityAdapter());
    Hive.registerAdapter(PhoneEntityAdapter());
    Hive.registerAdapter(CreateChildrenParamAdapter());
    Hive.registerAdapter(UpdateChildrenParamAdapter());
    Hive.registerAdapter(UpdateSchoolParamAdapter());
    Hive.registerAdapter(CreateSchoolParamAdapter());
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter();
  }

   static Future<void> _openHiveBoxes() async {

    await Hive.openBox(kAuthBox);
    await Hive.openBox<SchoolEntity>(kSchoolBox);
    await Hive.openBox<ChildrenEntity>(kChildrenBox);
    await Hive.openBox<CreateChildrenParam>(kSaveCreateChild);
    await Hive.openBox<UpdateChildrenParam>(kSaveUpdateChild);
    await Hive.openBox<CreateSchoolParam>(kSaveCreateSchool);
    await Hive.openBox<UpdateSchoolParam>(kSaveUpdateSchool);

   }
}

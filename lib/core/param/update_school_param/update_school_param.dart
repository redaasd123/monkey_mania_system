import 'package:hive/hive.dart';
part 'update_school_param.g.dart';

@HiveType(typeId: 7)
class UpdateSchoolParam {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final String? notes;
  @HiveField(3)
  final int id;

  UpdateSchoolParam({required this.id,required this.name, required this.address, this.notes});

  Map<String,dynamic> toJson()=>{
    "name":name,
    "address":address,
    "notes":notes
  };
}

//flutter packages pub run build_runner build --delete-conflicting-outputs
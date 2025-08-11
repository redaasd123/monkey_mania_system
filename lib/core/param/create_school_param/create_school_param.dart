import 'package:hive/hive.dart';

part 'create_school_param.g.dart';

@HiveType(typeId: 6)
class CreateSchoolParam {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final String? notes;

  CreateSchoolParam({required this.name, required this.address, this.notes});

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "notes": notes,
  };
}

//flutter pub run build_runner build

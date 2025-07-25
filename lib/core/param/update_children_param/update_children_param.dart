import 'package:hive/hive.dart';

part 'update_children_param.g.dart';

@HiveType(typeId: 5)
class UpdateChildrenParam {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final int id;
  @HiveField(3)
  final int school;
  @HiveField(4)
  final String birthDate;
  @HiveField(5)
  List<Map<String, dynamic>> phoneNumber;
  @HiveField(6)
  final String? notes;

  UpdateChildrenParam({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.school,
    required this.birthDate,
    this.notes,
  });

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "school": school,
      "birth_date": birthDate,
      "address": address,
      "notes": notes, //nullableZ
      "child_phone_numbers_set": phoneNumber
          .map(
            (e) => {
              "phone_number": {"value": e['value']},
              "relationship": e['relationship'],
            },
          )
          .toList(),
    };
  }
}

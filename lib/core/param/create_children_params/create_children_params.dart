import 'package:hive/hive.dart';
part 'create_children_params.g.dart';

@HiveType(typeId: 4)
class CreateChildrenParam {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final int? school;
  @HiveField(3)
  final String birthDate;
  @HiveField(4)
  final String? notes;
  @HiveField(5)
  List<Map<String, String>> phones;

  CreateChildrenParam({
    required this.name,
    required this.address,
    required this.school,
    required this.birthDate,
    this.notes,
    required this.phones,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name.trim(),
      'address': address,
      'school': school,
      'birth_date': birthDate,
      'notes': notes,
      "child_phone_numbers_set": phones
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

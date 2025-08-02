import 'package:hive/hive.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/entity/age/age_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/phone/phone_entity.dart';
part 'children_entity.g.dart';
@HiveType(typeId: 1)
class ChildrenEntity {
  @HiveField(0)
  final num? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? birthDate;
  @HiveField(3)
  final AgeEntity? age;
  @HiveField(4)
  final String? notes;
  @HiveField(5)
  final String? address;
  @HiveField(6)
  final bool? isActive;
  @HiveField(7)
  final bool? specialNeeds;
  @HiveField(8)
  final String? created;
  @HiveField(9)
  final String? updated;
  @HiveField(10)
  final String? createdBy;
  @HiveField(11)
  final int? school;
  @HiveField(12)
  final String? schoolName;
  @HiveField(13)
  final List<PhoneEntity>? childPhoneNumbersSet;

  ChildrenEntity({
    required this.schoolName,
    required this.id,
    required this.name,
    required this.birthDate,
    required this.age,
    required this.notes,
    required this.address,
    required this.isActive,
    required this.specialNeeds,
    required this.created,
    required this.updated,
    required this.createdBy,
    required this.school,
    required this.childPhoneNumbersSet,
  });
}

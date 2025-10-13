import 'package:hive/hive.dart';

part 'school_entity.g.dart';

@HiveType(typeId: 0)
class SchoolEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final String? notes;
  @HiveField(4)
  final DateTime created;
  @HiveField(5)
  final DateTime updated;
  @HiveField(6)
  final String createdBy;

  SchoolEntity({
    required this.id,
    required this.name,
    required this.address,
    this.notes,
    required this.created,
    required this.updated,
    required this.createdBy,
  });
}

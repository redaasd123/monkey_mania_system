
import 'package:hive/hive.dart';

part 'phone_entity.g.dart';
@HiveType(typeId: 3)
class PhoneEntity {
  @HiveField(0)
  final String? phoneNumber;
  @HiveField(1)
  final String? relationship;

  PhoneEntity({this.phoneNumber, this.relationship});
}

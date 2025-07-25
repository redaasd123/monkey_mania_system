
import 'package:hive/hive.dart';
part 'age_entity.g.dart';
@HiveType(typeId: 2)
class AgeEntity {
  @HiveField(0)
  final num? years;
  @HiveField(1)
  final num? months;
  @HiveField(2)
  final num? days;

  AgeEntity({this.years, this.months, this.days});
}

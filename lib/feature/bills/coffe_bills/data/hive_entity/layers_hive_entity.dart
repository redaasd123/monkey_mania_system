import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'layers_hive_entity.g.dart';

@HiveType(typeId: 8)
class LayersHiveEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String name;

   LayersHiveEntity({required this.name});

  @override
  List<Object?> get props => [name];
}

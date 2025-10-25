import 'package:equatable/equatable.dart';
class LayersEntity extends Equatable {
  final String name;
  const LayersEntity({required this.name});
  @override
  List<Object?> get props => [name];
}

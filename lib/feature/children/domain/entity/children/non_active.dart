import 'package:equatable/equatable.dart';

class ChildrenNonActiveEntity extends Equatable{

  final String name;
  final int id;

  const ChildrenNonActiveEntity({required this.name, required this.id});
  @override
  List<Object?> get props => [id,name];

}
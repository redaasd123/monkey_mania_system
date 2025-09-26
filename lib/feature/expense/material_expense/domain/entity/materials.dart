import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MaterialsEntity extends Equatable{
  final int id;
  final String name;

  MaterialsEntity({required this.id,required this.name});

  @override
  // TODO: implement props
  List<Object?> get props =>[id,name];
}

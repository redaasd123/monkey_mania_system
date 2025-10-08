import 'package:equatable/equatable.dart';

class LayersEntity extends Equatable{
  final String name;

 const LayersEntity({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}



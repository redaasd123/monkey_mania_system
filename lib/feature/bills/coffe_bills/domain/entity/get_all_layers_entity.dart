import 'package:equatable/equatable.dart';

class GetAllLayerEntity extends Equatable {
  final String? layer1;
  final String? layer2;
  final String? layer3;
  final String? product;
  final num? availableUnits;
  final dynamic? price;

  GetAllLayerEntity({
    required this.layer1,
    required this.layer2,
    required this.layer3,
    required this.product,
    required this.availableUnits,
    required this.price,
  });

  @override
  List<Object?> get props => [layer1,layer2,layer3,product,availableUnits,price];
}

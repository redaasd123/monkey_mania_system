import 'package:equatable/equatable.dart';

class LayersEntity extends Equatable{
  final String name;

 const LayersEntity({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}


// class LayerEntity extends Equatable {
//   final String name;        // اسم العنصر الأساسي للعرض
//   final String? layer1;     // للـ GetAllLayerEntity
//   final String? layer2;     // للـ GetAllLayerEntity
//   final String? layer3;     // للـ GetAllLayerEntity
//   final String? product;    // للـ GetAllLayerEntity
//   final num? availableUnits;
//   final double? price;
//
//   const LayerEntity({
//     required this.name,
//     this.layer1,
//     this.layer2,
//     this.layer3,
//     this.product,
//     this.availableUnits,
//     this.price,
//   });
//
//   @override
//   List<Object?> get props => [name, layer1, layer2, layer3, product, availableUnits, price];
// }

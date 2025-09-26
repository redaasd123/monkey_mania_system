import 'package:equatable/equatable.dart';

class MaterialExpenseItemEntity extends Equatable {

  final String material;
  final int quantity;
  final String unitPrice;
  final String totalPrice;
  final int id;

  const MaterialExpenseItemEntity({
    required this.material,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.id,
  });

  List<Object?> get props => [ material, unitPrice, totalPrice, id];
}

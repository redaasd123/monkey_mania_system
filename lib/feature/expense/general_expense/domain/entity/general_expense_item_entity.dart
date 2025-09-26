import 'package:equatable/equatable.dart';

class GeneralExpenseItemEntity extends Equatable {

  final String name;
  final int quantity;
  final String unitPrice;
  final String totalPrice;
  final int id;

  const GeneralExpenseItemEntity({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.id,
  });

  List<Object?> get props => [ name, unitPrice, totalPrice, id];
}

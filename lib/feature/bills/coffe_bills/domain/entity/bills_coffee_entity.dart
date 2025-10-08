import 'package:equatable/equatable.dart';

final class BillsCoffeeEntity extends Equatable{
  final int id;
final bool takeAway;
final dynamic totalPrice;
final num? tableNumber;
final num? billNumber;

 const BillsCoffeeEntity( {required this.id,required this.takeAway, required this.totalPrice, required this.tableNumber, required this.billNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [id,takeAway,takeAway, billNumber,totalPrice];
}
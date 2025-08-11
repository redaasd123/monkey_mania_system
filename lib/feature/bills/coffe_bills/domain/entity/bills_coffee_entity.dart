final class BillsCoffeeEntity {
  final int id;
final bool takeAway;
final dynamic totalPrice;
final num? tableNumber;
final num? billNumber;

  BillsCoffeeEntity( {required this.id,required this.takeAway, required this.totalPrice, required this.tableNumber, required this.billNumber});
}
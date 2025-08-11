class GetOneBillsCoffeeEntity {
  final int id;
  final int billNumber;
  final int tableNumber;
  final dynamic totalPrice;
  final bool takeAway;
  final List<Product> products;
  final List<dynamic> returnedProducts;
  final String createdBy;
  final String created;
  final String updated;
  final int createdById;

  GetOneBillsCoffeeEntity({
    required this.id,
    required this.billNumber,
    required this.tableNumber,
    required this.totalPrice,
    required this.takeAway,
    required this.products,
    required this.returnedProducts,
    required this.createdBy,
    required this.created,
    required this.updated,
    required this.createdById,
  });
}

class Product {
  final String unitPrice;
  final double totalPrice;
  final int quantity;
  final String notes;
  final String name;

  Product({
    required this.unitPrice,
    required this.totalPrice,
    required this.quantity,
    required this.notes,
    required this.name,
  });
}

class CreateBillsPCoffeeParam {
  final List<Products> product;
  final int billId;
  final int tableNumber;
  final bool takeAway;
  final int branchId;

  CreateBillsPCoffeeParam({
    required this.branchId,
    required this.product,
    required this.billId,
    required this.tableNumber,
    required this.takeAway,
  });

  Map<String, dynamic> toJson() {
    return {
      'products': product.map((product) => product.toJson()).toList(),
      "bill": billId,
      "table_number": tableNumber,
      "take_away": takeAway,
    };
  }


  String branchToQuery() {
    return "branch_id=$branchId";
  }
}

class Products {
  final String productType;
  final num productId;
  final int quantity;
  final String? notes;

  Map<String, dynamic> toJson() {
    final map = {
      'product_type': productType,
      'product_id': productId,
      'quantity': quantity,
    };

    if (notes != null && notes!.isNotEmpty) {
      map['notes'] = notes!;
    }

    return map;
  }

  Products({
    required this.productType,
    required this.productId,
    required this.quantity,
    required this.notes,
  });
}

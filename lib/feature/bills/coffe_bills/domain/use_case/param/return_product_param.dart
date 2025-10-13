import 'package:equatable/equatable.dart';

class ReturnProductsParam extends Equatable {
  final int id;
  final List<Products> products;

  const ReturnProductsParam({required this.products, required this.id});

  Map<String, dynamic> toJson() {
    return {'returned_products': products.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [products];
}

class Products extends Equatable {
  final String productType;
  final int productId;
  final int quantity;

  const Products({
    required this.productType,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_type": productType,
      "product_id": productId,
      "quantity": quantity,
    };
  }

  @override
  List<Object?> get props => [productType, productId, quantity];
}

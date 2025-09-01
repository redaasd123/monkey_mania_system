

class BillsCoffeeModel {
  BillsCoffeeModel({
      this.id, 
      this.billNumber, 
      this.tableNumber, 
      this.totalPrice, 
      this.takeAway, 
      this.bill, 
      this.products, 
      this.returnedProducts, 
      this.createdBy, 
      this.created, 
      this.updated,});

  BillsCoffeeModel.fromJson(dynamic json) {
    id = json['id'];
    billNumber = json['bill_number'];
    tableNumber = json['table_number'];
    totalPrice = json['total_price'];
    takeAway = json['take_away'];
    bill = json['bill'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    if (json['returned_products'] != null) {
      returnedProducts = [];
      json['returned_products'].forEach((v) {
        returnedProducts?.add(v);
      });
    }
    createdBy = json['created_by'];
    created = json['created'];
    updated = json['updated'];
  }
  int? id;
  num? billNumber;
  num? tableNumber;
  dynamic? totalPrice;
  bool? takeAway;
  num? bill;
  List<Products>? products;
  List<dynamic>? returnedProducts;
  String? createdBy;
  String? created;
  String? updated;
BillsCoffeeModel copyWith({  int? id,
  num? billNumber,
  num? tableNumber,
  dynamic totalPrice,
  bool? takeAway,
  num? bill,
  List<Products>? products,
  List<dynamic>? returnedProducts,
  String? createdBy,
  String? created,
  String? updated,
}) => BillsCoffeeModel(  id: id ?? this.id,
  billNumber: billNumber ?? this.billNumber,
  tableNumber: tableNumber ?? this.tableNumber,
  totalPrice: totalPrice ?? this.totalPrice,
  takeAway: takeAway ?? this.takeAway,
  bill: bill ?? this.bill,
  products: products ?? this.products,
  returnedProducts: returnedProducts ?? this.returnedProducts,
  createdBy: createdBy ?? this.createdBy,
  created: created ?? this.created,
  updated: updated ?? this.updated,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bill_number'] = billNumber;
    map['table_number'] = tableNumber;
    map['total_price'] = totalPrice;
    map['take_away'] = takeAway;
    map['bill'] = bill;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (returnedProducts != null) {
      map['returned_products'] = returnedProducts?.map((v) => v.toJson()).toList();
    }
    map['created_by'] = createdBy;
    map['created'] = created;
    map['updated'] = updated;
    return map;
  }

}

/// unit_price : "231.00"
/// total_price : 924
/// quantity : 4
/// notes : "extra sauce"
/// name : "waffle pistachio"

class Products {
  Products({
      this.unitPrice, 
      this.totalPrice, 
      this.quantity, 
      this.notes, 
      this.name,});

  Products.fromJson(dynamic json) {
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    notes = json['notes'];
    name = json['name'];
  }
  String? unitPrice;
  num? totalPrice;
  num? quantity;
  String? notes;
  String? name;
Products copyWith({  String? unitPrice,
  num? totalPrice,
  num? quantity,
  String? notes,
  String? name,
}) => Products(  unitPrice: unitPrice ?? this.unitPrice,
  totalPrice: totalPrice ?? this.totalPrice,
  quantity: quantity ?? this.quantity,
  notes: notes ?? this.notes,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit_price'] = unitPrice;
    map['total_price'] = totalPrice;
    map['quantity'] = quantity;
    map['notes'] = notes;
    map['name'] = name;
    return map;
  }

}
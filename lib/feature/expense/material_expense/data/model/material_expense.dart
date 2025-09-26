
class MaterialExpenseModel {
  MaterialExpenseModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  MaterialExpenseModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ResultsMaterialExpense.fromJson(v));
      });
    }
  }
  num? count;
  dynamic next;
  dynamic previous;
  List<ResultsMaterialExpense>? results;
MaterialExpenseModel copyWith({  num? count,
  dynamic next,
  dynamic previous,
  List<ResultsMaterialExpense>? results,
}) => MaterialExpenseModel(  count: count ?? this.count,
  next: next ?? this.next,
  previous: previous ?? this.previous,
  results: results ?? this.results,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 36
/// material : "استيلر خشب"
/// unit_price : "2.00"
/// total_price : "1000.00"
/// quantity : 500
/// branch : "سافانا"
/// created : "2025-09-24T17:44:46.515798+03:00"
/// updated : "2025-09-24T17:44:46.522330+03:00"
/// created_by : "ammar admin"
/// measure_unit : "كيس"
/// created_by_id : 1
/// material_id : 119
/// branch_id : 1

class ResultsMaterialExpense {
  ResultsMaterialExpense({
      this.id, 
      this.material, 
      this.unitPrice, 
      this.totalPrice, 
      this.quantity, 
      this.branch, 
      this.created, 
      this.updated, 
      this.createdBy, 
      this.measureUnit, 
      this.createdById, 
      this.materialId, 
      this.branchId,});

  ResultsMaterialExpense.fromJson(dynamic json) {
    id = json['id'];
    material = json['material'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    branch = json['branch'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    measureUnit = json['measure_unit'];
    createdById = json['created_by_id'];
    materialId = json['material_id'];
    branchId = json['branch_id'];
  }
  int? id;
  String? material;
  String? unitPrice;
  String? totalPrice;
  int? quantity;
  String? branch;
  String? created;
  String? updated;
  String? createdBy;
  String? measureUnit;
  num? createdById;
  num? materialId;
  num? branchId;
ResultsMaterialExpense copyWith({  int? id,
  String? material,
  String? unitPrice,
  String? totalPrice,
  int? quantity,
  String? branch,
  String? created,
  String? updated,
  String? createdBy,
  String? measureUnit,
  num? createdById,
  num? materialId,
  num? branchId,
}) => ResultsMaterialExpense(  id: id ?? this.id,
  material: material ?? this.material,
  unitPrice: unitPrice ?? this.unitPrice,
  totalPrice: totalPrice ?? this.totalPrice,
  quantity: quantity ?? this.quantity,
  branch: branch ?? this.branch,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  measureUnit: measureUnit ?? this.measureUnit,
  createdById: createdById ?? this.createdById,
  materialId: materialId ?? this.materialId,
  branchId: branchId ?? this.branchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['material'] = material;
    map['unit_price'] = unitPrice;
    map['total_price'] = totalPrice;
    map['quantity'] = quantity;
    map['branch'] = branch;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['measure_unit'] = measureUnit;
    map['created_by_id'] = createdById;
    map['material_id'] = materialId;
    map['branch_id'] = branchId;
    return map;
  }

}
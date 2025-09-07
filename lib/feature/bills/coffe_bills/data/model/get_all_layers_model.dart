/// id : 2
/// layer1 : "dessert"
/// layer2 : "fadge"
/// layer3 : "nutella"
/// name : "fadge nutella"
/// product : "fadge nutella"
/// branch : "تنوتن"
/// warning_units : 150
/// available_units : 451
/// warning_message : null
/// sold_units : 35
/// price : "231.00"
/// material_consumptions_set : [{"id":5,"material":"nutella","consumption":"0.100000","measure_unit":"kilo"},{"id":6,"material":"lotus","consumption":"0.100000","measure_unit":"kilo"}]
/// created : "2025-06-30T01:48:29.969954+03:00"
/// updated : "2025-07-05T00:16:07.050712+03:00"
/// created_by : "superuser1"
/// created_by_id : 1
/// product_id : 2
/// branch_id : 1

class GetAllLayersModel {
  GetAllLayersModel({
      this.id,
      this.layer1,
      this.layer2,
      this.layer3,
      this.name,
      this.product,
      this.branch,
      this.warningUnits,
      this.availableUnits,
      this.warningMessage,
      this.soldUnits,
      this.price,
      this.materialConsumptionsSet,
      this.created,
      this.updated,
      this.createdBy,
      this.createdById,
      this.productId,
      this.branchId,});

  GetAllLayersModel.fromJson(dynamic json) {
    id = json['id'];
    layer1 = json['layer1'];
    layer2 = json['layer2'];
    layer3 = json['layer3'];
    name = json['name'];
    product = json['product'];
    branch = json['branch'];
    warningUnits = json['warning_units'];
    availableUnits = json['available_units'];
    warningMessage = json['warning_message'];
    soldUnits = json['sold_units'];
    price = json['price'];
    if (json['material_consumptions_set'] != null) {
      materialConsumptionsSet = [];
      json['material_consumptions_set'].forEach((v) {
        materialConsumptionsSet?.add(MaterialConsumptionsSet.fromJson(v));
      });
    }
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    createdById = json['created_by_id'];
    productId = json['product_id'];
    branchId = json['branch_id'];
  }
  num? id;
  String? layer1;
  String? layer2;
  String? layer3;
  String? name;
  String? product;
  String? branch;
  num? warningUnits;
  num? availableUnits;
  dynamic warningMessage;
  num? soldUnits;
  dynamic? price;
  List<MaterialConsumptionsSet>? materialConsumptionsSet;
  String? created;
  String? updated;
  String? createdBy;
  num? createdById;
  num? productId;
  num? branchId;
GetAllLayersModel copyWith({  num? id,
  String? layer1,
  String? layer2,
  String? layer3,
  String? name,
  String? product,
  String? branch,
  num? warningUnits,
  num? availableUnits,
  dynamic warningMessage,
  num? soldUnits,
  dynamic? price,
  List<MaterialConsumptionsSet>? materialConsumptionsSet,
  String? created,
  String? updated,
  String? createdBy,
  num? createdById,
  num? productId,
  num? branchId,
}) => GetAllLayersModel(  id: id ?? this.id,
  layer1: layer1 ?? this.layer1,
  layer2: layer2 ?? this.layer2,
  layer3: layer3 ?? this.layer3,
  name: name ?? this.name,
  product: product ?? this.product,
  branch: branch ?? this.branch,
  warningUnits: warningUnits ?? this.warningUnits,
  availableUnits: availableUnits ?? this.availableUnits,
  warningMessage: warningMessage ?? this.warningMessage,
  soldUnits: soldUnits ?? this.soldUnits,
  price: price ?? this.price,
  materialConsumptionsSet: materialConsumptionsSet ?? this.materialConsumptionsSet,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  createdById: createdById ?? this.createdById,
  productId: productId ?? this.productId,
  branchId: branchId ?? this.branchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['layer1'] = layer1;
    map['layer2'] = layer2;
    map['layer3'] = layer3;
    map['name'] = name;
    map['product'] = product;
    map['branch'] = branch;
    map['warning_units'] = warningUnits;
    map['available_units'] = availableUnits;
    map['warning_message'] = warningMessage;
    map['sold_units'] = soldUnits;
    map['price'] = price;
    if (materialConsumptionsSet != null) {
      map['material_consumptions_set'] = materialConsumptionsSet?.map((v) => v.toJson()).toList();
    }
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['created_by_id'] = createdById;
    map['product_id'] = productId;
    map['branch_id'] = branchId;
    return map;
  }

}

/// id : 5
/// material : "nutella"
/// consumption : "0.100000"
/// measure_unit : "kilo"

class MaterialConsumptionsSet {
  MaterialConsumptionsSet({
      this.id,
      this.material,
      this.consumption,
      this.measureUnit,});

  MaterialConsumptionsSet.fromJson(dynamic json) {
    id = json['id'];
    material = json['material'];
    consumption = json['consumption'];
    measureUnit = json['measure_unit'];
  }
  num? id;
  String? material;
  String? consumption;
  String? measureUnit;
MaterialConsumptionsSet copyWith({  num? id,
  String? material,
  String? consumption,
  String? measureUnit,
}) => MaterialConsumptionsSet(  id: id ?? this.id,
  material: material ?? this.material,
  consumption: consumption ?? this.consumption,
  measureUnit: measureUnit ?? this.measureUnit,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['material'] = material;
    map['consumption'] = consumption;
    map['measure_unit'] = measureUnit;
    return map;
  }

}
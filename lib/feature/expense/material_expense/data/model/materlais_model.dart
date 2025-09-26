
class MaterialsModel {
  MaterialsModel({
      this.id, 
      this.name, 
      this.measureUnit, 
      this.material, 
      this.branch, 
      this.availableUnits, 
      this.created, 
      this.updated, 
      this.createdBy, 
      this.createdById, 
      this.materialId, 
      this.branchId,});

  MaterialsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    measureUnit = json['measure_unit'];
    material = json['material'];
    branch = json['branch'];
    availableUnits = json['available_units'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    createdById = json['created_by_id'];
    materialId = json['material_id'];
    branchId = json['branch_id'];
  }
  int? id;
  String? name;
  String? measureUnit;
  String? material;
  String? branch;
  String? availableUnits;
  String? created;
  String? updated;
  String? createdBy;
  num? createdById;
  num? materialId;
  num? branchId;
MaterialsModel copyWith({  int? id,
  String? name,
  String? measureUnit,
  String? material,
  String? branch,
  String? availableUnits,
  String? created,
  String? updated,
  String? createdBy,
  num? createdById,
  num? materialId,
  num? branchId,
}) => MaterialsModel(  id: id ?? this.id,
  name: name ?? this.name,
  measureUnit: measureUnit ?? this.measureUnit,
  material: material ?? this.material,
  branch: branch ?? this.branch,
  availableUnits: availableUnits ?? this.availableUnits,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  createdById: createdById ?? this.createdById,
  materialId: materialId ?? this.materialId,
  branchId: branchId ?? this.branchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['measure_unit'] = measureUnit;
    map['material'] = material;
    map['branch'] = branch;
    map['available_units'] = availableUnits;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['created_by_id'] = createdById;
    map['material_id'] = materialId;
    map['branch_id'] = branchId;
    return map;
  }

}
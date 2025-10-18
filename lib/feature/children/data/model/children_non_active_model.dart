

class ChildrenNonActiveModel {
  ChildrenNonActiveModel({
      this.id, 
      this.name, 
      this.birthDate, 
      this.age, 
      this.notes, 
      this.address, 
      this.isActive, 
      this.specialNeeds, 
      this.created, 
      this.updated, 
      this.createdBy, 
      this.school, 
      this.childPhoneNumbersSet, 
      this.schoolId, 
      this.createdById,});

  ChildrenNonActiveModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    birthDate = json['birth_date'];
    age = json['age'] != null ? Age.fromJson(json['age']) : null;
    notes = json['notes'];
    address = json['address'];
    isActive = json['is_active'];
    specialNeeds = json['special_needs'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    school = json['school'];
    if (json['child_phone_numbers_set'] != null) {
      childPhoneNumbersSet = [];
      json['child_phone_numbers_set'].forEach((v) {
        childPhoneNumbersSet?.add(ChildPhoneNumbersSet.fromJson(v));
      });
    }
    schoolId = json['school_id'];
    createdById = json['created_by_id'];
  }
  int? id;
  String? name;
  String? birthDate;
  Age? age;
  dynamic notes;
  String? address;
  bool? isActive;
  bool? specialNeeds;
  String? created;
  String? updated;
  String? createdBy;
  String? school;
  List<ChildPhoneNumbersSet>? childPhoneNumbersSet;
  num? schoolId;
  num? createdById;
ChildrenNonActiveModel copyWith({  int? id,
  String? name,
  String? birthDate,
  Age? age,
  dynamic notes,
  String? address,
  bool? isActive,
  bool? specialNeeds,
  String? created,
  String? updated,
  String? createdBy,
  String? school,
  List<ChildPhoneNumbersSet>? childPhoneNumbersSet,
  num? schoolId,
  num? createdById,
}) => ChildrenNonActiveModel(  id: id ?? this.id,
  name: name ?? this.name,
  birthDate: birthDate ?? this.birthDate,
  age: age ?? this.age,
  notes: notes ?? this.notes,
  address: address ?? this.address,
  isActive: isActive ?? this.isActive,
  specialNeeds: specialNeeds ?? this.specialNeeds,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  school: school ?? this.school,
  childPhoneNumbersSet: childPhoneNumbersSet ?? this.childPhoneNumbersSet,
  schoolId: schoolId ?? this.schoolId,
  createdById: createdById ?? this.createdById,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['birth_date'] = birthDate;
    if (age != null) {
      map['age'] = age?.toJson();
    }
    map['notes'] = notes;
    map['address'] = address;
    map['is_active'] = isActive;
    map['special_needs'] = specialNeeds;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['school'] = school;
    if (childPhoneNumbersSet != null) {
      map['child_phone_numbers_set'] = childPhoneNumbersSet?.map((v) => v.toJson()).toList();
    }
    map['school_id'] = schoolId;
    map['created_by_id'] = createdById;
    return map;
  }

}

/// phone_number : "11616161616"
/// relationship : "father"

class ChildPhoneNumbersSet {
  ChildPhoneNumbersSet({
      this.phoneNumber, 
      this.relationship,});

  ChildPhoneNumbersSet.fromJson(dynamic json) {
    phoneNumber = json['phone_number'];
    relationship = json['relationship'];
  }
  String? phoneNumber;
  String? relationship;
ChildPhoneNumbersSet copyWith({  String? phoneNumber,
  String? relationship,
}) => ChildPhoneNumbersSet(  phoneNumber: phoneNumber ?? this.phoneNumber,
  relationship: relationship ?? this.relationship,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = phoneNumber;
    map['relationship'] = relationship;
    return map;
  }

}

/// years : 0
/// months : 0
/// days : 16

class Age {
  Age({
      this.years, 
      this.months, 
      this.days,});

  Age.fromJson(dynamic json) {
    years = json['years'];
    months = json['months'];
    days = json['days'];
  }
  num? years;
  num? months;
  num? days;
Age copyWith({  num? years,
  num? months,
  num? days,
}) => Age(  years: years ?? this.years,
  months: months ?? this.months,
  days: days ?? this.days,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['years'] = years;
    map['months'] = months;
    map['days'] = days;
    return map;
  }

}
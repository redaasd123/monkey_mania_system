import 'package:monkey_app/feature/children/domain/entity/age/age_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/phone/phone_entity.dart';

/// id : 1
/// name : "احمد ابراهيم ابو سريع"
/// birth_date : "2024-08-30"
/// age : {"years":0,"months":9,"days":27}
/// notes : "special needs"
/// address : "new_damietta el qawas super market"
/// is_active : false
/// special_needs : true
/// created : "2025-02-21T20:48:13.070885+02:00"
/// updated : "2025-06-27T19:01:44.382737+03:00"
/// created_by : 1
/// school : 1
/// child_phone_numbers_set : [{"phone_number":"92399978912","relationship":"other"},{"phone_number":"12995990912","relationship":"sibling"}]

class ChildrenModel extends ChildrenEntity {
  ChildrenModel({
    this.schoolName,
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
  }) : super(
         schoolName: schoolName,
         id: id,
         notes: notes,
         name: name,
         updated: updated,
         createdBy: createdBy,
         created: created,
         address: address,
         age: age,
         birthDate: birthDate,
         childPhoneNumbersSet: childPhoneNumbersSet,
         isActive: isActive,
         school: school,
         specialNeeds: specialNeeds,
       );

  factory ChildrenModel.fromJson(dynamic json) {
    final age = json['age'] != null ? Age.fromJson(json['age']) : null;
    final phoneNumbers =
        (json['child_phone_numbers_set'] as List<dynamic>?)
            ?.map((v) => ChildPhoneNumbersSet.fromJson(v))
            .toList() ??
        [];

    return ChildrenModel(
      id: json['id'],
      name: json['name'],
      birthDate: json['birth_date'],
      age: age,
      notes: json['notes'],
      address: json['address'],
      isActive: json['is_active'],
      specialNeeds: json['special_needs'],
      created: json['created'],
      updated: json['updated'],
      createdBy: json['created_by']?.toString(),
      schoolName: json['school_name'],
      school: json['school_id'] is int
          ? json['school_id']
          : int.tryParse(json['school_id'].toString()),
      childPhoneNumbersSet: phoneNumbers,
    );
  }

  num? id;
  String? name;
  String? birthDate;
  Age? age;
  String? notes;
  String? address;
  bool? isActive;
  bool? specialNeeds;
  String? created;
  String? updated;
  String? createdBy;
  int? school;
  String? schoolName;
  List<ChildPhoneNumbersSet>? childPhoneNumbersSet;

  ChildrenModel copyWith({
    num? id,
    String? name,
    String? birthDate,
    Age? age,
    String? notes,
    String? address,
    bool? isActive,
    bool? specialNeeds,
    String? created,
    String? updated,
    String? createdBy,
    int? school,
    List<ChildPhoneNumbersSet>? childPhoneNumbersSet,
  }) => ChildrenModel(
    id: id ?? this.id,
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
    map['school_id'] = school;
    if (childPhoneNumbersSet != null) {
      map['child_phone_numbers_set'] = childPhoneNumbersSet
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }
}

/// phone_number : "92399978912"
/// relationship : "other"

class ChildPhoneNumbersSet extends PhoneEntity {
  ChildPhoneNumbersSet({String? phoneNumber, String? relationship})
    : super(phoneNumber: phoneNumber, relationship: relationship);

  factory ChildPhoneNumbersSet.fromJson(dynamic json) {
    return ChildPhoneNumbersSet(
      phoneNumber: json['phone_number'],
      relationship: json['relationship'],
    );
  }

  ChildPhoneNumbersSet copyWith({String? phoneNumber, String? relationship}) =>
      ChildPhoneNumbersSet(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        relationship: relationship ?? this.relationship,
      );

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber, 'relationship': relationship};
  }
}

/// years : 0
/// months : 9
/// days : 27

class Age extends AgeEntity {
  Age({this.years, this.months, this.days})
    : super(days: days, months: months, years: years);

  Age.fromJson(dynamic json) {
    years = json['years'];
    months = json['months'];
    days = json['days'];
  }

  num? years;
  num? months;
  num? days;

  Age copyWith({num? years, num? months, num? days}) => Age(
    years: years ?? this.years,
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

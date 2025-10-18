import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';

/// id : 1
/// name : "تنوتن"
/// address : "sdf"
/// indoor : true
/// allowed_age : "3.00"
/// delay_allowed_time : 1
/// delay_fine_interval : 30
/// delay_fine_value : "0.50"
/// created : "2025-02-21T20:47:50.713751+02:00"
/// updated : "2025-02-21T20:47:50.713781+02:00"
/// created_by : 1
/// manager : null
/// hour_prices_set : [{"id":1,"children_count":3,"hour_price":"5.00","half_hour_price":"10.00"}]

class BranchModel extends BranchEntity {
  BranchModel({
    this.id,
    this.name,
    this.address,
    this.indoor,
    this.allowedAge,
    this.delayAllowedTime,
    this.delayFineInterval,
    this.delayFineValue,
    this.created,
    this.updated,
    this.createdBy,
    this.manager,
    this.hourPricesSet,
  }) : super(name: name ?? '', id: id ?? 0);

  factory BranchModel.fromJson(dynamic json) {
    return BranchModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      indoor: json['indoor'],
      allowedAge: json['allowed_age'],
      delayAllowedTime: json['delay_allowed_time'],
      delayFineInterval: json['delay_fine_interval'],
      delayFineValue: json['delay_fine_value'],
      created: json['created'],
      updated: json['updated'],
      createdBy: json['created_by'],
      manager: json['manager'],
      hourPricesSet: (json['hour_prices_set'] as List<dynamic>?)
          ?.map((v) => HourPricesSet.fromJson(v))
          .toList(),
    );
  }

  int? id;
  String? name;
  String? address;
  bool? indoor;
  String? allowedAge;
  num? delayAllowedTime;
  num? delayFineInterval;
  String? delayFineValue;
  String? created;
  String? updated;
  String? createdBy;
  dynamic manager;
  List<HourPricesSet>? hourPricesSet;

  BranchModel copyWith({
    int? id,
    String? name,
    String? address,
    bool? indoor,
    String? allowedAge,
    num? delayAllowedTime,
    num? delayFineInterval,
    String? delayFineValue,
    String? created,
    String? updated,
    String? createdBy,
    dynamic manager,
    List<HourPricesSet>? hourPricesSet,
  }) => BranchModel(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    indoor: indoor ?? this.indoor,
    allowedAge: allowedAge ?? this.allowedAge,
    delayAllowedTime: delayAllowedTime ?? this.delayAllowedTime,
    delayFineInterval: delayFineInterval ?? this.delayFineInterval,
    delayFineValue: delayFineValue ?? this.delayFineValue,
    created: created ?? this.created,
    updated: updated ?? this.updated,
    createdBy: createdBy ?? this.createdBy,
    manager: manager ?? this.manager,
    hourPricesSet: hourPricesSet ?? this.hourPricesSet,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['indoor'] = indoor;
    map['allowed_age'] = allowedAge;
    map['delay_allowed_time'] = delayAllowedTime;
    map['delay_fine_interval'] = delayFineInterval;
    map['delay_fine_value'] = delayFineValue;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['manager'] = manager;
    if (hourPricesSet != null) {
      map['hour_prices_set'] = hourPricesSet?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// children_count : 3
/// hour_price : "5.00"
/// half_hour_price : "10.00"

class HourPricesSet {
  HourPricesSet({
    this.id,
    this.childrenCount,
    this.hourPrice,
    this.halfHourPrice,
  });

  HourPricesSet.fromJson(dynamic json) {
    id = json['id'];
    childrenCount = json['children_count'];
    hourPrice = json['hour_price'];
    halfHourPrice = json['half_hour_price'];
  }

  num? id;
  num? childrenCount;
  String? hourPrice;
  String? halfHourPrice;

  HourPricesSet copyWith({
    num? id,
    num? childrenCount,
    String? hourPrice,
    String? halfHourPrice,
  }) => HourPricesSet(
    id: id ?? this.id,
    childrenCount: childrenCount ?? this.childrenCount,
    hourPrice: hourPrice ?? this.hourPrice,
    halfHourPrice: halfHourPrice ?? this.halfHourPrice,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['children_count'] = childrenCount;
    map['hour_price'] = hourPrice;
    map['half_hour_price'] = halfHourPrice;
    return map;
  }
}

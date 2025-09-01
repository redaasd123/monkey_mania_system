// get_one_bills_model.dart
class GetOneBillsModel {
  GetOneBillsModel({
    this.id,
    this.cash,
    this.instapay,
    this.visa,
    this.isSubscription,
    this.timePrice,
    this.productsPrice,
    this.children,
    this.discountValue,
    this.discountType,
    this.branch,
    this.productBillsSet,
    this.isActive,
    this.isAllowedAge,
    this.hourPrice,
    this.halfHourPrice,
    this.totalPrice,
    this.spentTime,
    this.childrenCount,
    this.moneyUnbalance,
    this.finished,
    this.created,
    this.updated,
    this.createdBy,
    this.finishedBy,
    this.createdById,
    this.finishedById,
    this.branchId,
  });

  GetOneBillsModel.fromJson(dynamic json) {
    id = json['id'];
    cash = json['cash']?.toString();
    instapay = json['instapay']?.toString();
    visa = json['visa']?.toString();
    isSubscription = json['is_subscription'];
    timePrice = json['time_price'];
    productsPrice = json['products_price']?.toString();
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
    discountValue = json['discount_value']?.toString();
    discountType = json['discount_type'];
    branch = json['branch'];
    if (json['product_bills_set'] != null) {
      productBillsSet = [];
      json['product_bills_set'].forEach((v) {
        productBillsSet?.add(v);
      });
    }
    isActive = json['is_active'];
    isAllowedAge = json['is_allowed_age'];
    hourPrice = json['hour_price']?.toString();
    halfHourPrice = json['half_hour_price']?.toString();
    totalPrice = json['total_price'];
    spentTime = json['spent_time'];
    childrenCount = json['children_count'];
    moneyUnbalance = json['money_unbalance'];
    finished = json['finished'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    finishedBy = json['finished_by'];
    createdById = json['created_by_id'];
    finishedById = json['finished_by_id'];
    branchId = json['branch_id'];
  }

  num? id;
  String? cash;
  String? instapay;
  String? visa;
  bool? isSubscription;
  dynamic? timePrice;
  String? productsPrice;
  List<Children>? children;
  String? discountValue;
  dynamic discountType;
  String? branch;
  List<dynamic>? productBillsSet;
  bool? isActive;
  bool? isAllowedAge;
  String? hourPrice;
  String? halfHourPrice;
  dynamic? totalPrice;
  num? spentTime;
  num? childrenCount;
  num? moneyUnbalance;
  String? finished;
  String? created;
  String? updated;
  String? createdBy;
  String? finishedBy;
  num? createdById;
  num? finishedById;
  num? branchId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cash'] = cash;
    map['instapay'] = instapay;
    map['visa'] = visa;
    map['is_subscription'] = isSubscription;
    map['time_price'] = timePrice;
    map['products_price'] = productsPrice;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    map['discount_value'] = discountValue;
    map['discount_type'] = discountType;
    map['branch'] = branch;
    if (productBillsSet != null) {
      map['product_bills_set'] = productBillsSet;
    }
    map['is_active'] = isActive;
    map['is_allowed_age'] = isAllowedAge;
    map['hour_price'] = hourPrice;
    map['half_hour_price'] = halfHourPrice;
    map['total_price'] = totalPrice;
    map['spent_time'] = spentTime;
    map['children_count'] = childrenCount;
    map['money_unbalance'] = moneyUnbalance;
    map['finished'] = finished;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['finished_by'] = finishedBy;
    map['created_by_id'] = createdById;
    map['finished_by_id'] = finishedById;
    map['branch_id'] = branchId;
    return map;
  }
}

class Children {
  Children({this.id, this.name, this.phoneNumbers});

  Children.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['phone_numbers'] != null) {
      phoneNumbers = [];
      json['phone_numbers'].forEach((v) {
        phoneNumbers?.add(PhoneNumbers.fromJson(v));
      });
    }
  }

  num? id;
  String? name;
  List<PhoneNumbers>? phoneNumbers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (phoneNumbers != null) {
      map['phone_numbers'] = phoneNumbers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PhoneNumbers {
  PhoneNumbers({this.phoneNumber, this.relationship});

  PhoneNumbers.fromJson(dynamic json) {
    phoneNumber = json['phone_number']?.toString();
    relationship = json['relationship'];
  }

  String? phoneNumber;
  String? relationship;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = phoneNumber;
    map['relationship'] = relationship;
    return map;
  }
}


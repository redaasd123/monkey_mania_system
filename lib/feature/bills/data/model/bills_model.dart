import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';

/// id : 1
/// cash : "0.00"
/// instapay : "0.00"
/// visa : "500.00"
/// is_subscription : false
/// time_price : "10.00"
/// products_price : "0.00"
/// children : [{"id":3,"name":"testchild2","phone_numbers":[{"phone_number":"12340678912","relationship":"other"},{"phone_number":"12343670912","relationship":"other"}]},{"id":4,"name":"testchild3","phone_numbers":[{"phone_number":"12340608912","relationship":"other"},{"phone_number":"12343670902","relationship":"other"}]},{"id":5,"name":"testchild4","phone_numbers":[{"phone_number":"12040608912","relationship":"other"},{"phone_number":"12343070902","relationship":"other"}]}]
/// discount_value : "0.0000"
/// discount_type : null
/// branch : 1
/// product_bills_set : []
/// is_active : false
/// hour_price : "5.00"
/// half_hour_price : "10.00"
/// total_price : "10.00"
/// spent_time : 36
/// children_count : 3
/// money_unbalance : 490
/// finished : "2025-06-30T04:53:41.815348+03:00"
/// created : "2025-06-30T04:16:51.754772+03:00"
/// updated : "2025-06-30T04:53:41.816328+03:00"
/// created_by : 1
/// finished_by : 1

class BillsModel extends BillsEntity{
  BillsModel({
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
      this.finishedBy,}):
        super(SpentTime: spentTime,TotalPrice: totalPrice,ChildrenCount: childrenCount,
     name: children!=null&&children.isNotEmpty?children.first.name:'',
      phoneNumber:  (children != null &&
          children.isNotEmpty &&
          children.first.phoneNumbers != null &&
          children.first.phoneNumbers!.isNotEmpty)
        ? children.first.phoneNumbers!.first.phoneNumber ?? ''
      : '',);

  BillsModel.fromJson(dynamic json)
      : super(
    SpentTime: json['spent_time'],
    TotalPrice: json['total_price'],
    ChildrenCount: json['children_count'],
    name: json['children'] != null && json['children'].isNotEmpty
        ? json['children'][0]['name'] ?? ''
        : '',
    phoneNumber: json['children'] != null &&
        json['children'].isNotEmpty &&
        json['children'][0]['phone_numbers'] != null &&
        json['children'][0]['phone_numbers'].isNotEmpty
        ? json['children'][0]['phone_numbers'][0]['phone_number'] ?? ''
        : '',
  ) {
    // باقي الفيلدات هنا
    id = json['id'];
    cash = json['cash'];
    instapay = json['instapay'];
    visa = json['visa'];
    isSubscription = json['is_subscription'];
    timePrice = json['time_price'];
    productsPrice = json['products_price'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
    branch = json['branch'];
    if (json['product_bills_set'] != null) {
      productBillsSet = [];
      json['product_bills_set'].forEach((v) {
        productBillsSet?.add(v); // فقط احتفظ بالقيمة كما هي إن لم تكن تعرف نوعها
      });
    }
    isActive = json['is_active'];
    hourPrice = json['hour_price'];
    halfHourPrice = json['half_hour_price'];
    totalPrice = json['total_price'];
    spentTime = json['spent_time'];
    childrenCount = json['children_count'];
    moneyUnbalance = json['money_unbalance'];
    finished = json['finished'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    finishedBy = json['finished_by'];
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
  dynamic? finishedBy;
BillsModel copyWith({  num? id,
  String? cash,
  String? instapay,
  String? visa,
  bool? isSubscription,
  dynamic? timePrice,
  String? productsPrice,
  List<Children>? children,
  String? discountValue,
  dynamic discountType,
  String? branch,
  List<dynamic>? productBillsSet,
  bool? isActive,
  String? hourPrice,
  String? halfHourPrice,
  dynamic? totalPrice,
  num? spentTime,
  num? childrenCount,
  num? moneyUnbalance,
  String? finished,
  String? created,
  String? updated,
  String? createdBy,
  dynamic? finishedBy,
}) => BillsModel(  id: id ?? this.id,
  cash: cash ?? this.cash,
  instapay: instapay ?? this.instapay,
  visa: visa ?? this.visa,
  isSubscription: isSubscription ?? this.isSubscription,
  timePrice: timePrice ?? this.timePrice,
  productsPrice: productsPrice ?? this.productsPrice,
  children: children ?? this.children,
  discountValue: discountValue ?? this.discountValue,
  discountType: discountType ?? this.discountType,
  branch: branch ?? this.branch,
  productBillsSet: productBillsSet ?? this.productBillsSet,
  isActive: isActive ?? this.isActive,
  hourPrice: hourPrice ?? this.hourPrice,
  halfHourPrice: halfHourPrice ?? this.halfHourPrice,
  totalPrice: totalPrice ?? this.totalPrice,
  spentTime: spentTime ?? this.spentTime,
  childrenCount: childrenCount ?? this.childrenCount,
  moneyUnbalance: moneyUnbalance ?? this.moneyUnbalance,
  finished: finished ?? this.finished,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  finishedBy: finishedBy ?? this.finishedBy,
);
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
      map['product_bills_set'] = productBillsSet?.map((v) => v.toJson()).toList();
    }
    map['is_active'] = isActive;
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
    return map;
  }

}

/// id : 3
/// name : "testchild2"
/// phone_numbers : [{"phone_number":"12340678912","relationship":"other"},{"phone_number":"12343670912","relationship":"other"}]

class Children {
  Children({
      this.id, 
      this.name, 
      this.phoneNumbers,});

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
Children copyWith({  num? id,
  String? name,
  List<PhoneNumbers>? phoneNumbers,
}) => Children(  id: id ?? this.id,
  name: name ?? this.name,
  phoneNumbers: phoneNumbers ?? this.phoneNumbers,
);
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

/// phone_number : "12340678912"
/// relationship : "other"

class PhoneNumbers {
  PhoneNumbers({
      this.phoneNumber, 
      this.relationship,});

  PhoneNumbers.fromJson(dynamic json) {
    phoneNumber = json['phone_number'];
    relationship = json['relationship'];
  }
  String? phoneNumber;
  String? relationship;
PhoneNumbers copyWith({  String? phoneNumber,
  String? relationship,
}) => PhoneNumbers(  phoneNumber: phoneNumber ?? this.phoneNumber,
  relationship: relationship ?? this.relationship,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = phoneNumber;
    map['relationship'] = relationship;
    return map;
  }

}
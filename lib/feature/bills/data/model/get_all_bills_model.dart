// import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
//
// class GetAllBillsModel extends BillsEntity {
//   GetAllBillsModel({
//     this.id,
//     this.cash,
//     this.instapay,
//     this.visa,
//     this.isSubscription,
//     this.timePrice,
//     this.productsPrice,
//     this.children,
//     this.discountValue,
//     this.discountType,
//     this.branch,
//     this.productBillsSet,
//     this.isActive,
//     this.hourPrice,
//     this.halfHourPrice,
//     this.totalPrice,
//     this.spentTime,
//     this.childrenCount,
//     this.moneyUnbalance,
//     this.finished,
//     this.created,
//     this.updated,
//     this.createdBy,
//     this.finishedBy,
//   }) : super(
//     children: children ?? [], // ✅ null safety
//     id: id,
//     SpentTime: spentTime,
//     TotalPrice: totalPrice,
//     ChildrenCount: childrenCount,
//   );
//
//   factory GetAllBillsModel.fromJson(Map<String, dynamic> json) {
//     return GetAllBillsModel(
//       id: json['id'],
//       cash: json['cash'],
//       instapay: json['instapay'],
//       visa: json['visa'],
//       isSubscription: json['is_subscription'],
//       timePrice: json['time_price'],
//       productsPrice: json['products_price'],
//       children: json['children'] != null
//           ? List<Children>.from(json['children'].map((v) => Children.fromJson(v)))
//           : [],
//       discountValue: json['discount_value'],
//       discountType: json['discount_type'],
//       branch: json['branch'],
//       productBillsSet: json['product_bills_set'] != null
//           ? List<dynamic>.from(json['product_bills_set'])
//           : [],
//       isActive: json['is_active'],
//       hourPrice: json['hour_price'],
//       halfHourPrice: json['half_hour_price'],
//       totalPrice: json['total_price'],
//       spentTime: json['spent_time'],
//       childrenCount: json['children_count'],
//       moneyUnbalance: json['money_unbalance'],
//       finished: json['finished'],
//       created: json['created'],
//       updated: json['updated'],
//       createdBy: json['created_by'],
//       finishedBy: json['finished_by'],
//     );
//   }
//
//   num? id;
//   String? cash;
//   String? instapay;
//   String? visa;
//   bool? isSubscription;
//   dynamic timePrice;
//   String? productsPrice;
//   List<Children>? children;
//   String? discountValue;
//   dynamic discountType;
//   String? branch;
//   List<dynamic>? productBillsSet;
//   bool? isActive;
//   String? hourPrice;
//   String? halfHourPrice;
//   dynamic totalPrice;
//   num? spentTime;
//   num? childrenCount;
//   num? moneyUnbalance;
//   String? finished;
//   String? created;
//   String? updated;
//   String? createdBy;
//   dynamic finishedBy;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'cash': cash,
//       'instapay': instapay,
//       'visa': visa,
//       'is_subscription': isSubscription,
//       'time_price': timePrice,
//       'products_price': productsPrice,
//       'children': children?.map((v) => v.toJson()).toList(),
//       'discount_value': discountValue,
//       'discount_type': discountType,
//       'branch': branch,
//       'product_bills_set': productBillsSet,
//       'is_active': isActive,
//       'hour_price': hourPrice,
//       'half_hour_price': halfHourPrice,
//       'total_price': totalPrice,
//       'spent_time': spentTime,
//       'children_count': childrenCount,
//       'money_unbalance': moneyUnbalance,
//       'finished': finished,
//       'created': created,
//       'updated': updated,
//       'created_by': createdBy,
//       'finished_by': finishedBy,
//     };
//   }
// }
//
// class Children {
//   Children({this.id, this.name, this.phoneNumbers});
//
//   factory Children.fromJson(Map<String, dynamic> json) {
//     return Children(
//       id: json['id'],
//       name: json['name'],
//       phoneNumbers: json['phone_numbers'] != null
//           ? List<PhoneNumbers>.from(json['phone_numbers'].map((v) => PhoneNumbers.fromJson(v)))
//           : [],
//     );
//   }
//
//   num? id;
//   String? name;
//   List<PhoneNumbers>? phoneNumbers;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'phone_numbers': phoneNumbers?.map((v) => v.toJson()).toList(),
//     };
//   }
// }
//
// class PhoneNumbers {
//   PhoneNumbers({this.phoneNumber, this.relationship});
//
//   factory PhoneNumbers.fromJson(Map<String, dynamic> json) {
//     return PhoneNumbers(
//       phoneNumber: json['phone_number'],
//       relationship: json['relationship'],
//     );
//   }
//
//   String? phoneNumber;
//   String? relationship;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'phone_number': phoneNumber,
//       'relationship': relationship,
//     };
//   }
// }
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';

class GetAllBillsModel extends BillsEntity {
  GetAllBillsModel({
    required int id,
    String? cash,
    String? instapay,
    String? visa,
    dynamic? timePrice,
    String? productsPrice,
    dynamic? totalPrice,
    String? discountValue,
    String? discountType,
    String? branch,
    num? spentTime,
    num? childrenCount,
    List<Children>? children,
    String? hourPrice,
    String? halfHourPrice,
    double? moneyUnbalance,
    DateTime? finished,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? finishedBy,
    bool? isSubscription,
    bool? isActive,
    List<dynamic>? productBillsSet,
  }) : super(
    id: id,
    cash: cash,
    instapay: instapay,
    visa: visa,
    isSubscription: isSubscription,
    timePrice: timePrice,
    productsPrice: productsPrice,
    children: children,
    discountValue: discountValue,
    discountType: discountType,
    branch: branch,
    productBillsSet: productBillsSet,
    isActive: isActive,
    hourPrice: hourPrice,
    halfHourPrice: halfHourPrice,
    totalPrice: totalPrice,
    spentTime: spentTime,
    childrenCount: childrenCount,
    moneyUnbalance: moneyUnbalance,
    finished: finished,
    created: created,
    updated: updated,
    createdBy: createdBy,
    finishedBy: finishedBy,
  );

  factory GetAllBillsModel.fromJson(Map<String, dynamic> json) {
    return GetAllBillsModel(
      id: json['id'],
      cash: json['cash'],
      instapay: json['instapay'],
      visa: json['visa'],
      isSubscription: json['is_subscription'],
      timePrice: json['time_price'],
      productsPrice: json['products_price'],
      totalPrice: json['total_price'],
      discountValue: json['discount_value'],
      discountType: json['discount_type'],
      branch: json['branch'],
      spentTime: json['spent_time'],
      childrenCount: json['children_count'],
      hourPrice: json['hour_price'],
      halfHourPrice: json['half_hour_price'],
      moneyUnbalance: (json['money_unbalance'] as num?)?.toDouble(),
      finished: json['finished'] != null ? DateTime.parse(json['finished']) : null,
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      updated: json['updated'] != null ? DateTime.parse(json['updated']) : null,
      createdBy: json['created_by'],
      finishedBy: json['finished_by'],
      isActive: json['is_active'],
      productBillsSet: json['product_bills_set'] != null
          ? List<dynamic>.from(json['product_bills_set'])
          : [],
      children: json['children'] != null
          ? List<Children>.from(
          json['children'].map((v) => Children.fromJson(v)))
          : [],
    );
  }
}

class Children {
  final num? id;
  final String? name;
  final List<PhoneNumbers>? phoneNumbers;

  Children({this.id, this.name, this.phoneNumbers});

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      id: json['id'],
      name: json['name'],
      phoneNumbers: json['phone_numbers'] != null
          ? List<PhoneNumbers>.from(
          json['phone_numbers'].map((v) => PhoneNumbers.fromJson(v)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_numbers': phoneNumbers?.map((v) => v.toJson()).toList(),
    };
  }
}

class PhoneNumbers {
  final String? phoneNumber;
  final String? relationship;

  PhoneNumbers({this.phoneNumber, this.relationship});

  factory PhoneNumbers.fromJson(Map<String, dynamic> json) {
    return PhoneNumbers(
      phoneNumber: json['phone_number'],
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'relationship': relationship,
    };
  }
}

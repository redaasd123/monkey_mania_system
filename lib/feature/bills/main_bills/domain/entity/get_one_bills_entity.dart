class GetOneBillsEntity {
  final num? id;
  final double? cash;
  final double? instapay;
  final double? visa;
  final double? timePrice;
  final double? productsPrice;
  final double? totalPrice;
  final double? discountValue;
  final String? discountType;
  final String? branch;
  final num? spentTime;
  final num? childrenCount;
  final List<ChildrenEntity>? children;
  final double? hourPrice;
  final double? halfHourPrice;
  final double? moneyUnbalance;
  final DateTime? finished;
  final DateTime? created;
  final DateTime? updated;
  final String? createdBy;
  final String? finishedBy;
  final bool? isSubscription;
  final bool? isActive;
  final List<dynamic>? productBillsSet;

  const GetOneBillsEntity({
    required this.id,
    this.cash,
    this.instapay,
    this.visa,
    this.timePrice,
    this.productsPrice,
    this.totalPrice,
    this.discountValue,
    this.discountType,
    this.branch,
    this.spentTime,
    this.childrenCount,
    this.children,
    this.hourPrice,
    this.halfHourPrice,
    this.moneyUnbalance,
    this.finished,
    this.created,
    this.updated,
    this.createdBy,
    this.finishedBy,
    this.isSubscription,
    this.isActive,
    this.productBillsSet,
  });
}

class ChildrenEntity {
  final num? id;
  final String? name;
  final List<PhoneNumberEntity>? phoneNumbers;

  const ChildrenEntity({this.id, this.name, this.phoneNumbers});
}

class PhoneNumberEntity {
  final String? phoneNumber;
  final String? relationship;

  const PhoneNumberEntity({this.phoneNumber, this.relationship});
}

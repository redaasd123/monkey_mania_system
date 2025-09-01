import '../../data/model/all_bills_model/get_all_bills_model.dart';

class BillsEntity {
  final int id;
  final String? cash;
  final String? instapay;
  final String? visa;
  final dynamic? timePrice;
  final String? productsPrice;
  final dynamic? totalPrice;
  final String? discountValue;
  final String? discountType;
  final String? branch;
  final num? spentTime;
  final num? childrenCount;
  final List<Children>? children;
  final String? hourPrice;
  final String? halfHourPrice;
  final double? moneyUnbalance;
  final DateTime? finished;
  final DateTime? created;
  final DateTime? updated;
  final String? createdBy;
  final String? finishedBy;
  final bool? isSubscription;
  final bool? isActive;
  final List<dynamic>? productBillsSet;

  BillsEntity({
    required this.id,
    required this.cash,
    required this.instapay,
    required this.visa,
    required this.timePrice,
    required this.productsPrice,
    required this.totalPrice,
    required this.discountValue,
    required this.discountType,
    required this.branch,
    required this.spentTime,
    required this.childrenCount,
    required this.children,
    required this.hourPrice,
    required this.halfHourPrice,
    required this.moneyUnbalance,
    required this.finished,
    required this.created,
    required this.updated,
    required this.createdBy,
    required this.finishedBy,
    required this.isSubscription,
    required this.isActive,
    required this.productBillsSet,
  });
}

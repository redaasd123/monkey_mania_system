import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String kidsSales;
  final String kidsSalesDifferenceFromYesterday;
  final String cafeSales;
  final String cafeSalesDifferenceFromYesterday;
  final String childrenCount;
  final String childrenCountDifferenceFromYesterday;
  final String subscriptionsSales;
  final String subscriptionsCount;
  final String staffWithdrawsTotal;
  final String staffRequestedWithdrawCount;
  final String moneyUnbalance;
  final String cash;
  final String instapay;
  final String visa;

  const HomeEntity({
    required this.kidsSales,
    required this.kidsSalesDifferenceFromYesterday,
    required this.cafeSales,
    required this.cafeSalesDifferenceFromYesterday,
    required this.childrenCount,
    required this.childrenCountDifferenceFromYesterday,
    required this.subscriptionsSales,
    required this.subscriptionsCount,
    required this.staffWithdrawsTotal,
    required this.staffRequestedWithdrawCount,
    required this.moneyUnbalance,
    required this.cash,
    required this.instapay,
    required this.visa,
  });

  @override
  List<Object?> get props => [
    kidsSales,
    kidsSalesDifferenceFromYesterday,
    cafeSales,
    cafeSalesDifferenceFromYesterday,
    childrenCount,
    childrenCountDifferenceFromYesterday,
    subscriptionsSales,
    subscriptionsCount,
    staffWithdrawsTotal,
    staffRequestedWithdrawCount,
    moneyUnbalance,
    cash,
    instapay,
    visa,
  ];
}

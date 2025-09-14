import 'package:monkey_app/feature/home/data/model/home_model.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';

extension HomeModelMapper on HomeModel {
  HomeEntity toEntity() {
    return HomeEntity(
      kidsSales: todaysKidsSales?.toString() ?? "0",
      kidsSalesDifferenceFromYesterday: kidsSalesDifferenceFromYesterday ?? "0",
      cafeSales: todaysCafeSales?.toString() ?? "0",
      cafeSalesDifferenceFromYesterday: cafeSalesDifferenceFromYesterday ?? "0",
      childrenCount: todaysChildrenCount?.toString() ?? "0",
      childrenCountDifferenceFromYesterday: childrenCountDifferenceFromYesterday ?? "0",
      subscriptionsSales: todaysSubscriptionsSales?.toString() ?? "0",
      subscriptionsCount: todaysSubscriptionsCount?.toString() ?? "0",
      staffWithdrawsTotal: todaysStaffWithdrawsTotal?.toString() ?? "0",
      staffRequestedWithdrawCount: todaysStaffRequestedWithdrawCount?.toString() ?? "0",
      moneyUnbalance: todaysMoneyUnbalance ?? "0",
      cash: todaysCash?.toString() ?? "0",
      instapay: todaysInstapay?.toString() ?? "0",
      visa: todaysVisa?.toString() ?? "0",
    );
  }
}

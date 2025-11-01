class HomeModel {
  HomeModel({
    this.todaysKidsSales,
    this.kidsSalesDifferenceFromYesterday,
    this.todaysCafeSales,
    this.cafeSalesDifferenceFromYesterday,
    this.todaysChildrenCount,
    this.childrenCountDifferenceFromYesterday,
    this.todaysSubscriptionsSales,
    this.todaysSubscriptionsCount,
    this.todaysStaffWithdrawsTotal,
    this.todaysStaffRequestedWithdrawCount,
    this.todaysMoneyUnbalance,
    this.todaysCash,
    this.todaysInstapay,
    this.todaysVisa,
  });

  HomeModel.fromJson(dynamic json) {
    todaysKidsSales = json['todays_kids_sales'];
    kidsSalesDifferenceFromYesterday = json['kids_sales_difference_from_yesterday'];
    todaysCafeSales = json['todays_cafe_sales'];
    cafeSalesDifferenceFromYesterday = json['cafe_sales_difference_from_yesterday'];
    todaysChildrenCount = json['todays_children_count'];
    childrenCountDifferenceFromYesterday = json['children_count_difference_from_yesterday'];
    todaysSubscriptionsSales = json['todays_subscriptions_sales'];
    todaysSubscriptionsCount = json['todays_subscriptions_count'];
    todaysStaffWithdrawsTotal = json['todays_staff_withdraws_total'];
    todaysStaffRequestedWithdrawCount = json['todays_staff_requested_withdraw_count'];
    todaysMoneyUnbalance = json['todays_money_unbalance'];
    todaysCash = json['todays_cash'];
    todaysInstapay = json['todays_instapay'];
    todaysVisa = json['todays_visa'];
  }

  String? todaysKidsSales;
  String? kidsSalesDifferenceFromYesterday;
  String? todaysCafeSales;
  String? cafeSalesDifferenceFromYesterday;
  String? todaysChildrenCount;
  String? childrenCountDifferenceFromYesterday;
  String? todaysSubscriptionsSales;
  String? todaysSubscriptionsCount;
  String? todaysStaffWithdrawsTotal;
  String? todaysStaffRequestedWithdrawCount;
  String? todaysMoneyUnbalance;
  String? todaysCash;
  String? todaysInstapay;
  String? todaysVisa;

  HomeModel copyWith({
    String? todaysKidsSales,
    String? kidsSalesDifferenceFromYesterday,
    String? todaysCafeSales,
    String? cafeSalesDifferenceFromYesterday,
    String? todaysChildrenCount,
    String? childrenCountDifferenceFromYesterday,
    String? todaysSubscriptionsSales,
    String? todaysSubscriptionsCount,
    String? todaysStaffWithdrawsTotal,
    String? todaysStaffRequestedWithdrawCount,
    String? todaysMoneyUnbalance,
    String? todaysCash,
    String? todaysInstapay,
    String? todaysVisa,
  }) =>
      HomeModel(
        todaysKidsSales: todaysKidsSales ?? this.todaysKidsSales,
        kidsSalesDifferenceFromYesterday: kidsSalesDifferenceFromYesterday ?? this.kidsSalesDifferenceFromYesterday,
        todaysCafeSales: todaysCafeSales ?? this.todaysCafeSales,
        cafeSalesDifferenceFromYesterday: cafeSalesDifferenceFromYesterday ?? this.cafeSalesDifferenceFromYesterday,
        todaysChildrenCount: todaysChildrenCount ?? this.todaysChildrenCount,
        childrenCountDifferenceFromYesterday: childrenCountDifferenceFromYesterday ?? this.childrenCountDifferenceFromYesterday,
        todaysSubscriptionsSales: todaysSubscriptionsSales ?? this.todaysSubscriptionsSales,
        todaysSubscriptionsCount: todaysSubscriptionsCount ?? this.todaysSubscriptionsCount,
        todaysStaffWithdrawsTotal: todaysStaffWithdrawsTotal ?? this.todaysStaffWithdrawsTotal,
        todaysStaffRequestedWithdrawCount: todaysStaffRequestedWithdrawCount ?? this.todaysStaffRequestedWithdrawCount,
        todaysMoneyUnbalance: todaysMoneyUnbalance ?? this.todaysMoneyUnbalance,
        todaysCash: todaysCash ?? this.todaysCash,
        todaysInstapay: todaysInstapay ?? this.todaysInstapay,
        todaysVisa: todaysVisa ?? this.todaysVisa,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['todays_kids_sales'] = todaysKidsSales;
    map['kids_sales_difference_from_yesterday'] = kidsSalesDifferenceFromYesterday;
    map['todays_cafe_sales'] = todaysCafeSales;
    map['cafe_sales_difference_from_yesterday'] = cafeSalesDifferenceFromYesterday;
    map['todays_children_count'] = todaysChildrenCount;
    map['children_count_difference_from_yesterday'] = childrenCountDifferenceFromYesterday;
    map['todays_subscriptions_sales'] = todaysSubscriptionsSales;
    map['todays_subscriptions_count'] = todaysSubscriptionsCount;
    map['todays_staff_withdraws_total'] = todaysStaffWithdrawsTotal;
    map['todays_staff_requested_withdraw_count'] = todaysStaffRequestedWithdrawCount;
    map['todays_money_unbalance'] = todaysMoneyUnbalance;
    map['todays_cash'] = todaysCash;
    map['todays_instapay'] = todaysInstapay;
    map['todays_visa'] = todaysVisa;
    return map;
  }
}

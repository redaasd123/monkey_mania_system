import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';

import '../../../../../../core/utils/langs_key.dart';

class HomeViewBodyItem extends StatelessWidget {
  final HomeEntity data;

  const HomeViewBodyItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dashboardItems = [
      DashboardItem(
        icon: FontAwesomeIcons.child,
        title: LangKeys.children.tr(),
        value: data.childrenCount,
        note: "+${data.childrenCountDifferenceFromYesterday}",
        color: Colors.pinkAccent,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.cartShopping,
        title: LangKeys.isSubscription.tr(),
        value: "US\$ ${data.subscriptionsSales}",
        note: "${data.subscriptionsCount} ${LangKeys.isSubscription.tr()}",
        color: Colors.blueAccent,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.coffee,
        title: LangKeys.coffeeBills.tr(),
        value: "US\$ ${data.cafeSales}",
        note: "+${data.cafeSalesDifferenceFromYesterday}",
        color: Colors.brown,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.sackDollar,
        title: LangKeys.kidsSales.tr(),
        // You can add it in LangKeys if not exists
        value: "US\$ ${data.kidsSales}",
        note: "+${data.kidsSalesDifferenceFromYesterday}",
        color: Colors.green,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.wallet,
        title: LangKeys.staffWithdraws.tr(),
        // Add to LangKeys if missing
        value: "US\$ ${data.staffWithdrawsTotal}",
        note: "${data.staffRequestedWithdrawCount} ${LangKeys.actions.tr()}",
        color: Colors.orange,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.creditCard,
        title: LangKeys.visa.tr(),
        value: "US\$ ${data.visa}",
        note: "VISA",
        color: Colors.deepPurple,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.moneyBill,
        title: LangKeys.cash.tr(),
        value: "US\$ ${data.cash}",
        note: "CASH",
        color: Colors.teal,
      ),
      DashboardItem(
        icon: FontAwesomeIcons.mobileScreen,
        title: LangKeys.instapay.tr(),
        value: "US\$ ${data.instapay}",
        note: LangKeys.instapay.tr(),
        color: Colors.indigo,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: dashboardItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = dashboardItems[index];
        return DashboardCard(
          icon: item.icon,
          title: item.title,
          value: item.value,
          note: item.note,
          color: item.color,
        );
      },
    );
  }
}

class DashboardItem {
  final IconData icon;
  final String title;
  final String value;
  final String note;
  final Color color;

  DashboardItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.note,
    required this.color,
  });
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String note;
  final Color color;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 75),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white.withOpacity(0.3),
            child: FaIcon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 1),
                Flexible(
                  child: Text(
                    note,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 10, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

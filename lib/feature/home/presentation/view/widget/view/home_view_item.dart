import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';

class HomeViewBodyItem extends StatelessWidget {
  final HomeEntity data;

  const HomeViewBodyItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dashboardItems = [
      DashboardItem(
        icon: FontAwesomeIcons.child,
        title: "الأطفال",
        value: data.childrenCount,
        note: "+${data.childrenCountDifferenceFromYesterday}",
        colors: [Colors.pink.shade200, Colors.purple.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.cartShopping,
        title: "الاشتراكات",
        value: "US\$ ${data.subscriptionsSales}",
        note: "${data.subscriptionsCount} اشتراك",
        colors: [Colors.blue.shade200, Colors.indigo.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.coffee,
        title: "الكافيه",
        value: "US\$ ${data.cafeSales}",
        note: "+${data.cafeSalesDifferenceFromYesterday}",
        colors: [Colors.teal.shade200, Colors.green.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.sackDollar,
        title: "مبيعات الأطفال",
        value: "US\$ ${data.kidsSales}",
        note: "+${data.kidsSalesDifferenceFromYesterday}",
        colors: [Colors.green.shade200, Colors.lightGreen.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.wallet,
        title: "سحب الموظفين",
        value: "US\$ ${data.staffWithdrawsTotal}",
        note: "${data.staffRequestedWithdrawCount} طلب",
        colors: [Colors.orange.shade200, Colors.red.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.creditCard,
        title: "الدفع بالفيزا",
        value: "US\$ ${data.visa}",
        note: "VISA",
        colors: [Colors.orange.shade100, Colors.orange.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.moneyBill,
        title: "الدفع بالكاش",
        value: "US\$ ${data.cash}",
        note: "CASH",
        colors: [Colors.green.shade100, Colors.green.shade300],
      ),
      DashboardItem(
        icon: FontAwesomeIcons.mobileScreen,
        title: "انستا باي",
        value: "US\$ ${data.instapay}",
        note: "INSTAPAY",
        colors: [Colors.blue.shade100, Colors.blue.shade300],
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
          colors: item.colors,
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
  final List<Color> colors;

  DashboardItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.note,
    required this.colors,
  });
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String note;
  final List<Color> colors;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.note,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // عرض كامل الشاشة
      height: 75, // ارتفاع أصغر
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // تقليل padding
      child: Row(
        children: [
          CircleAvatar(
            radius: 18, // أصغر شوية
            backgroundColor: Colors.white.withOpacity(0.3),
            child: FaIcon(icon, color: Colors.white, size: 18), // أصغر
          ),
          const SizedBox(width: 12), // تقليل المسافة
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, // أصغر
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 2), // تقليل المسافة
                Text(value,
                    style: const TextStyle(
                        fontSize: 14, // أصغر
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                const SizedBox(height: 1), // أصغر
                Text(note,
                    style: const TextStyle(
                        fontSize: 10, // أصغر
                        color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

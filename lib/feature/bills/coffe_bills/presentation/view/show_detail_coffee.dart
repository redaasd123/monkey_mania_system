import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';

import '../../../../../core/utils/constans.dart';

class ShowDetailCoffee extends StatefulWidget {
  const ShowDetailCoffee({super.key, required this.id});

  final int id;

  @override
  State<ShowDetailCoffee> createState() => _ShowDetailCoffeeState();
}

class _ShowDetailCoffeeState extends State<ShowDetailCoffee> {
  @override
  void initState() {
    super.initState();
    context.read<GetOneBillsCoffeeCubit>().getOneBillsCoffee(widget.id);
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("تفاصيل الفاتورة"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: BlocBuilder<GetOneBillsCoffeeCubit, GetOneBillsCoffeeState>(
          builder: (context, state) {
            if (state.status == GetOneBillsCoffeeStatus.getOneLoading) {
              return const  Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue, // غير اللون زي ما تحب
                  size: 60,
                ),
              );
            } else if (state.status == GetOneBillsCoffeeStatus.getOneSuccess) {
              final bill = state.getOneBills;
              if (bill == null) {
                return const Center(child: Text("لا توجد فاتورة"));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoTile(Icons.receipt, "رقم الفاتورة", bill.billNumber.toString()),
                    _buildInfoTile(Icons.table_bar, "رقم الطاولة", bill.tableNumber.toString()),
                    _buildInfoTile(Icons.monetization_on, "الإجمالي", bill.totalPrice.toString()),
                    _buildInfoTile(Icons.shopping_bag, "تيك أواي", bill.takeAway ? "نعم" : "لا"),
                    _buildInfoTile(Icons.person, "أنشئت بواسطة", bill.createdBy),
                    _buildInfoTile(Icons.date_range, "تاريخ الإنشاء", bill.created),
                    _buildInfoTile(Icons.update, "آخر تحديث", bill.updated),
                    _buildInfoTile(Icons.perm_identity, "معرّف المستخدم", bill.createdById.toString()),

                    const SizedBox(height: 20),
                    Text("🛒 المنتجات",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),

                    ...(bill.products ?? []).map((product) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                              child: Icon(Icons.local_cafe, color: theme.colorScheme.primary),
                            ),
                            title: Text(
                              product.name,
                              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Text(
                                  "سعر الوحدة: ${product.unitPrice} | الكمية: ${product.quantity}",
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "الإجمالي: ${product.totalPrice}",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (product.notes != null && product.notes!.isNotEmpty)
                                  Text(
                                    "ملاحظات: ${product.notes}",
                                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 20),
                    Text("🔄 المنتجات المرتجعة",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    if ((bill.returnedProducts ?? []).isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("لا توجد منتجات مرتجعة"),
                      )
                    else
                      ...(bill.returnedProducts ?? []).map((item) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Icon(Icons.undo, color: theme.colorScheme.error),
                            title: Text(item.toString()),
                          ),
                        );
                      }).toList(),
                  ],
                ),
              );
            } else if (state.status == GetOneBillsCoffeeStatus.getOneFailure) {
              return Center(child: Text("خطأ: ${state.errMessage ?? 'حدث خطأ'}"));
            } else {
              return const SizedBox();
            }
          },
        ),
    );
  }
}

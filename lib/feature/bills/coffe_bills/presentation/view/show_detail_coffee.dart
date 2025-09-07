
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';
import '../manager/coffee_bills/coffee_bills_cubit.dart';

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
//  @override
//   void initState() {
//     super.initState();
//     final cubit = context.read<CoffeeBillsCubit>();
//     if (cubit.state.getOneBills == null ||
//         cubit.state.getOneBills?.id != widget.id) {
//       cubit.getOneBillsCoffee(widget.id);
//     }
//   }
  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.brown),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text("تفاصيل الفاتورة"),
        backgroundColor: Colors.brown[400],
      ),
      body: BlocBuilder<GetOneBillsCoffeeCubit, GetOneBillsCoffeeState>(
        builder: (context, state) {
          // حالة التحميل
          if (state.status == GetOneBillsCoffeeStatus.getOneLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // حالة النجاح
          else if (state.status == GetOneBillsCoffeeStatus.getOneSuccess) {
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
                  const Text("🛒 المنتجات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...(bill.products ?? []).map((product) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown.withOpacity(0.1),
                            child: const Icon(Icons.local_cafe, color: Colors.brown),
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                "سعر الوحدة: ${product.unitPrice} | الكمية: ${product.quantity}",
                                style: const TextStyle(fontSize: 13, color: Colors.black87),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "الإجمالي: ${product.totalPrice}",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.green, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4),
                              if (product.notes != null && product.notes!.isNotEmpty)
                                Text(
                                  "ملاحظات: ${product.notes}",
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),
                  const Text("🔄 المنتجات المرتجعة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          leading: const Icon(Icons.undo, color: Colors.red),
                          title: Text(item.toString()),
                        ),
                      );
                    }).toList(),
                ],
              ),
            );
          }

          // حالة الفشل
          else if (state.status == GetOneBillsCoffeeStatus.getOneFailure) {
            return Center(child: Text("خطأ: ${state.errMessage ?? 'حدث خطأ'}"));
          }

          // الحالة الافتراضية
          else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}






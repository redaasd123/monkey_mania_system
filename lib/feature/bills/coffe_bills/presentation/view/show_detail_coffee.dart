import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';

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
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value, style: theme.textTheme.bodyMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.bills.tr()), //
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
            return const Center(
              child: SpinKitFadingCircle(color: Colors.blue, size: 60),
            );
          } else if (state.status == GetOneBillsCoffeeStatus.getOneSuccess) {
            final bill = state.getOneBills;
            if (bill == null) {
              return Center(child: Text(LangKeys.notFound.tr()));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoTile(
                    Icons.receipt,
                    LangKeys.billsNumber.tr(),
                    bill.billNumber.toString(),
                  ),
                  _buildInfoTile(
                    Icons.table_bar,
                    LangKeys.tableNumber.tr(),
                    bill.tableNumber.toString(),
                  ),
                  _buildInfoTile(
                    Icons.monetization_on,
                    LangKeys.totalPrice.tr(),
                    bill.totalPrice.toString(),
                  ),
                  _buildInfoTile(
                    Icons.shopping_bag,
                    LangKeys.takeAway.tr(),
                    bill.takeAway ? LangKeys.ok.tr() : LangKeys.cansel.tr(),
                  ),
                  _buildInfoTile(
                    Icons.person,
                    LangKeys.createdBy.tr(),
                    bill.createdBy,
                  ),
                  _buildInfoTile(
                    Icons.date_range,
                    LangKeys.createdAt.tr(),
                    bill.created,
                  ),
                  _buildInfoTile(
                    Icons.update,
                    LangKeys.lastUpdate.tr(),
                    bill.updated,
                  ),
                  _buildInfoTile(
                    Icons.perm_identity,
                    LangKeys.users.tr(),
                    bill.createdById.toString(),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "🛒 ${LangKeys.productsPrice.tr()}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ...(bill.products ?? []).map((product) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: theme.colorScheme.primary
                                .withOpacity(0.1),
                            child: Icon(
                              Icons.local_cafe,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            product.name,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                "${LangKeys.productsPrice.tr()}: ${product.unitPrice} | ${LangKeys.quantity.tr()}: ${product.quantity}",
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${LangKeys.totalPrice.tr()}: ${product.totalPrice}",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (product.notes != null &&
                                  product.notes!.isNotEmpty)
                                Text(
                                  "${LangKeys.notes.tr()}: ${product.notes}",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),
                  Text(
                    "🔄 ${LangKeys.returnedProducts.tr()}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if ((bill.returnedProducts ?? []).isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(LangKeys.notFound.tr()),
                    )
                  else
                    ...(bill.returnedProducts).map((item) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Icon(
                            Icons.undo,
                            color: theme.colorScheme.error,
                          ),
                          title: Text(item.toString()),
                        ),
                      );
                    }).toList(),
                ],
              ),
            );
          } else if (state.status == GetOneBillsCoffeeStatus.getOneFailure) {
            return Center(
              child: Text(
                "${LangKeys.systemMessage.tr()}: ${state.errMessage ?? LangKeys.notFound.tr()}",
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

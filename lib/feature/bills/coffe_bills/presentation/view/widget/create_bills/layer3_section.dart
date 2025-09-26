import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/create_bills/send_order_button.dart';

import '../../../../../../../core/widget/widget/custom_text_field.dart';
import '../../../manager/coffee_bills/layers_cubit.dart';
import '../../../manager/coffee_bills/order_cubit.dart';
import 'card_layer3.dart';
import 'create_order_bottom_sheet.dart';
import 'detail_order_widget.dart';
import 'field_bills_id.dart';

class Layer3Section extends StatelessWidget {
  const Layer3Section({
    required this.images,
    required this.colorScheme,
    required this.billIdController,
    required this.tableNumberController,
    required this.selectedBillId,
    required this.takeAway,
    required this.formKey,
    required this.onBillIdSelected,
    required this.onTakeAwayChanged,
  });

  final List<String> images;
  final ColorScheme colorScheme;
  final TextEditingController billIdController;
  final TextEditingController tableNumberController;
  final int? selectedBillId;
  final bool takeAway;
  final GlobalKey<FormState> formKey;
  final ValueChanged<int> onBillIdSelected;
  final ValueChanged<bool> onTakeAwayChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<OrdersCubit, List<OrderItem>>(
          builder: (context, state) {
            if (state.isEmpty) return const SizedBox.shrink();
            return DetailOrderWidget(state: state);
          },
        ),
        BlocBuilder<OrdersCubit, List<OrderItem>>(
          builder: (context, orders) {
            if (orders.isEmpty) return const SizedBox.shrink();
            return Column(
              children: [
                _OrdersFormSection(
                  billIdController: billIdController,
                  tableNumberController: tableNumberController,
                  colorScheme: colorScheme,
                  onBillIdSelected: onBillIdSelected,
                  takeAway: takeAway,
                  onTakeAwayChanged: onTakeAwayChanged,
                ),
                const SizedBox(height: 16),
                SendOrderButton(
                  formKey: formKey,
                  selectedBillId: selectedBillId,
                  tableNumberController: tableNumberController,
                  takeAway: takeAway,
                ),
              ],
            );
          },
        ),
        BlocBuilder<LayersCubit, LayersState>(
          builder: (context, state) {
            return BlocBuilder<LayersCubit, LayersState>(
              builder: (context, state) {
                return Column(
                  children: List.generate(state.layer3.length, (index) {
                    final item = state.layer3[index];
                    final imagePath = images[index % images.length];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            builder: (_) {
                              return OrderBottomSheet(
                                item: item,
                                imagePath: imagePath,
                                onAdd:
                                    (quantity, notes, selectedItem, imagePath) {
                                      context.read<OrdersCubit>().addOrder(
                                        OrderItem(
                                          product: selectedItem,
                                          quantity: quantity,
                                          notes: notes,
                                          imagePath: imagePath,
                                        ),
                                      );
                                    },
                              );
                            },
                          );
                        },
                        child: CardLayer3Widget(
                          imagePath: imagePath,
                          item: item,
                        ),
                      ),
                    );
                  }),
                );
              },
            );

            // return GridView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   padding: const EdgeInsets.all(12),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 1,
            //     crossAxisSpacing: 12,
            //     mainAxisSpacing: 12,
            //     //childAspectRatio: 0.75,
            //   ),
            //   itemCount: state.layer3.length,
            //   itemBuilder: (context, index) {
            //     final item = state.layer3[index];
            //     final imagePath = images[index % images.length];
            //     return InkWell(
            //       borderRadius: BorderRadius.circular(16),
            //       onTap: () {
            //         showModalBottomSheet(
            //           context: context,
            //           isScrollControlled: true,
            //           shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.vertical(
            //               top: Radius.circular(24),
            //             ),
            //           ),
            //           builder: (_) {
            //             return OrderBottomSheet(
            //               item: item,
            //               imagePath: imagePath,
            //               onAdd: (quantity, notes, selectedItem, imagePath) {
            //                 context.read<OrdersCubit>().addOrder(
            //                   OrderItem(
            //                     product: selectedItem,
            //                     quantity: quantity,
            //                     notes: notes,
            //                     imagePath: imagePath,
            //                   ),
            //                 );
            //               },
            //             );
            //           },
            //         );
            //       },
            //       child: CardLayer3Widget(
            //         imagePath: imagePath,
            //         item: item,
            //       ),
            //     );
            //   },
            // );
          },
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              context.read<LayersCubit>().getLayerOTowCashed();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.black45],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    "الرجوع إلى Layer 2",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OrdersFormSection extends StatelessWidget {
  const _OrdersFormSection({
    required this.billIdController,
    required this.tableNumberController,
    required this.colorScheme,
    required this.onBillIdSelected,
    required this.takeAway,
    required this.onTakeAwayChanged,
  });

  final TextEditingController billIdController;
  final TextEditingController tableNumberController;
  final ColorScheme colorScheme;
  final ValueChanged<int> onBillIdSelected;
  final bool takeAway;
  final ValueChanged<bool> onTakeAwayChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFieldBillsID(
            billsCtrl: billIdController,
            colorScheme: colorScheme,
            onSelected: onBillIdSelected,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomTextField(
            label: 'table',
            hint: 'Enter Table Number',
            controller: tableNumberController,
            keyboardType: TextInputType.phone,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const Text(
                'Take Away',
                style: TextStyle(color: Colors.teal, fontSize: 14),
              ),
              Switch(value: takeAway, onChanged: onTakeAwayChanged),
            ],
          ),
        ),
      ],
    );
  }
}

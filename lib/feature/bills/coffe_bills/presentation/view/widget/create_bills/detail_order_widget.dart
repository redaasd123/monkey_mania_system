import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../manager/coffee_bills/order_cubit.dart';
import 'create_order_bottom_sheet.dart';

class DetailOrderWidget extends StatelessWidget {
  const DetailOrderWidget({super.key, required this.state});

  final List<OrderItem> state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 180, // smaller height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (context, index) {
          final order = state[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) {
                        return OrderBottomSheet(
                          initialNotes: order.notes,
                          initialQuantity: order.quantity,
                          item: order.product,
                          imagePath: order.imagePath,
                          onAdd: (quantity, notes, selectedItem, imagePath) {
                            context.read<OrdersCubit>().updateOrder(
                              index,
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
                  child: Container(
                    width: 140, // smaller width
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ✅ Image with quantity overlay
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  order.imagePath,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "×${order.quantity}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // ✅ Product name
                        Text(
                          order.product.product ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // ✅ Price × Quantity
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.moneyBill, size: 12, color: Colors.white70),
                            const SizedBox(width: 3),
                            Text(
                              "${order.product.price ?? 0} × ${order.quantity}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // ✅ Notes (if any)
                        if ((order.notes ?? '').isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order.notes!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // ✅ Small delete button
                Positioned(
                  top: -6,
                  right: -6,
                  child: GestureDetector(
                    onTap: () => context.read<OrdersCubit>().removeOrder(index),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.redAccent,
                      child: const Icon(Icons.close, size: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (context, index) {
          final order = state[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (context) {
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
                    width: 170,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        //0xFF481B5E
                        colors: [Color(0xFF141E30), Color(0xFF243B55)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // صورة المنتج مع الكمية
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 46,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(46),
                                child: Image.asset(
                                  order.imagePath,
                                  height: 92,
                                  width: 92,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.deepPurpleAccent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "×${order.quantity}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // اسم المنتج
                        Text(
                          order.product.product ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // السعر × الكمية
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.lightGreen],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                FontAwesomeIcons.moneyBill,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${order.product.price ?? 0} × ${order.quantity}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        // الملاحظات
                        if ((order.notes ?? '').isNotEmpty)
                          Container(
                            width: 130,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white24,
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              order.notes!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // زر الإلغاء
                Positioned(
                  top: -8,
                  right: -8,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.redAccent,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<OrdersCubit>().removeOrder(index);
                      },
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

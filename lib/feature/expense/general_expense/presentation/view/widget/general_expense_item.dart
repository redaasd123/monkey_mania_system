
import 'package:flutter/material.dart';

import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';

class GeneralExpenseItem extends StatelessWidget {
  final GeneralExpenseItemEntity item;
  const GeneralExpenseItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 4,
        shadowColor: colorScheme.shadow.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // Name
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20, color: colorScheme.primary),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Total Price
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Icon(Icons.price_change_outlined,
                        size: 20,  color: colorScheme.primary),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        item.totalPrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Quantity
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Icon(Icons.countertops,
                        size: 20, color: colorScheme.primary),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        item.quantity.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

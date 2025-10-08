import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import '../../../../../core/utils/styles.dart';

class ChildrenViewBodyItem extends StatelessWidget {
  const ChildrenViewBodyItem({super.key, required this.childrenEntity});

  final ChildrenEntity childrenEntity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 70,
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Name
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 18, color: colorScheme.primary),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          childrenEntity.name ?? "لا يوجد اسم",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle14.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Address


                const SizedBox(width: 10),

                // Phone
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: colorScheme.primary,),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          childrenEntity.childPhoneNumbersSet?.isNotEmpty == true
                              ? childrenEntity.childPhoneNumbersSet!.first.phoneNumber ?? "لا يوجد رقم"
                              : "لا يوجد رقم",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle12.copyWith(
                            fontStyle: FontStyle.italic,
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // View details
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.kShowDetailChildren,
                      extra: childrenEntity,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility,
                          size: 16, color: colorScheme.primary),
                      const SizedBox(width: 4),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }
}




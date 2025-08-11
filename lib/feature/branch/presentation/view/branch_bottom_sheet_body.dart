import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import '../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../manager/branch_cubit.dart';

class BranchBottomSheetBody extends StatefulWidget {
  const BranchBottomSheetBody({super.key});

  @override
  State<BranchBottomSheetBody> createState() => _BranchBottomSheetBodyState();
}

class _BranchBottomSheetBodyState extends State<BranchBottomSheetBody> {
  DateTime? endDate;
  DateTime? startDate;
  final List<int> selectIndex = [];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return BlocBuilder<BranchCubit, BranchState>(
      builder: (context, state) {
        if (state is BranchSuccessState) {
          final branches = state.branch;
          return StatefulBuilder(
            builder: (context, setState) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height *
                      0.8, // أقصى ارتفاع 80% من الشاشة
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: branches.length,
                          itemBuilder: (context, index) {
                            final isSelected = selectIndex.contains(index);
                            return ListTile(
                              title: Text(branches[index].name ?? ''),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : const Icon(Icons.circle_outlined),
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectIndex.remove(index);
                                  } else {
                                    selectIndex.add(index);
                                  }
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: startDate == null
                                ? 'تاريخ البداية'
                                : 'تاريخ البداية: ${startDate!.toLocal().toString().split(' ')[0]}',
                            suffixIcon: const Icon(Icons.date_range),
                          ),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (picked != null) {
                              setState(() => startDate = picked);
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: endDate == null
                                ? 'تاريخ النهاية'
                                : 'تاريخ النهاية: ${endDate!.toLocal().toString().split(' ')[0]}',
                            suffixIcon: const Icon(Icons.date_range),
                          ),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (picked != null) {
                              setState(() => endDate = picked);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color.primary,
                          ),
                          onPressed: () async {
                            final selectBranch = selectIndex
                                .map((b) => branches[b].id)
                                .toList();
                            if (selectBranch.isEmpty) {
                              showRedFlush(
                                context,
                                'من فضلك اختر فرع علي الاقل',
                              );
                              return;
                            }
                            if (startDate != null && endDate != null) {
                              if (endDate!.isBefore(startDate!)) {
                                showRedFlush(
                                  context,
                                  'تاريخ النهاية يجب أن يكون بعد تاريخ البداية',
                                );
                                return;
                              }
                            }
                            final bool bothDatesSelected =
                                startDate != null && endDate != null;
                            final bool onlyOneDateSelected =
                                (startDate != null && endDate == null) ||
                                (startDate == null && endDate != null);

                            if (onlyOneDateSelected) {
                              showRedFlush(
                                context,
                                'يرجى اختيار تاريخ البداية والنهاية معًا أو تركهم فارغين',
                              );
                              return;
                            }

                            if (bothDatesSelected &&
                                endDate!.isBefore(startDate!)) {
                              showRedFlush(
                                context,
                                'تاريخ النهاية يجب أن يكون بعد تاريخ البداية',
                              );
                              return;
                            }
                            print('🧩 Selected Branch IDs: $selectBranch');
                            print('📅 Start Date: $startDate');
                            print('📅 End Date: $endDate');

                            final param = FetchBillsParam(
                              branch: selectBranch,
                              startDate: startDate,
                              endDate: endDate,
                            );
                            print('🛰 Sending Param: $param');
                            Navigator.pop(context, param);
                          },
                          child: Text(
                            'تم',
                            style: Styles.textStyle20.copyWith(
                              color: color.onPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is BranchInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: SizedBox());
        }
      },
    );
  }
}

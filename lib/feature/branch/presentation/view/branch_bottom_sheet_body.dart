import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';

import '../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../manager/branch_cubit.dart';

class BranchBottomSheetBody extends StatefulWidget {
  const BranchBottomSheetBody({super.key});

  @override
  State<BranchBottomSheetBody> createState() => _BranchBottomSheetBodyState();
}

class _BranchBottomSheetBodyState extends State<BranchBottomSheetBody> {
  DateTime? startDate;
  DateTime? endDate;
  late List<int> selectIndex = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return BlocBuilder<BranchCubit, BranchState>(
      builder: (context, state) {
        if (state.status == BranchStatus.success && state.branches != null) {
          final branches = state.branches!;
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.background, color.primary.withOpacity(0.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        LangKeys.selectBranch.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.primary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: branches.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final isSelected = selectIndex.contains(index);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectIndex.remove(index);
                                  } else {
                                    selectIndex.add(index);
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: isSelected
                                        ? [Colors.greenAccent, Colors.green]
                                        : [
                                            Colors.grey.shade200,
                                            Colors.grey.shade300,
                                          ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        branches[index].name ?? '',
                                        style: TextStyle(
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildDateField(
                              context: context,
                              label: LangKeys.startDate.tr(),
                              selectedDate: startDate,
                              onDatePicked: (date) =>
                                  setState(() => startDate = date),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDateField(
                              context: context,
                              label: LangKeys.endDate.tr(),
                              selectedDate: endDate,
                              onDatePicked: (date) =>
                                  setState(() => endDate = date),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 6,
                            backgroundColor: color.primary,
                          ),
                          onPressed: () {
                            final selectedBranch = selectIndex
                                .map((i) => branches[i].id)
                                .toList();

                            if (selectedBranch.isEmpty) {
                              showRedFlush(
                                context,
                                LangKeys.chooseAtLeastOneBranch.tr(),
                              );
                              return;
                            }

                            if ((startDate != null && endDate == null) ||
                                (startDate == null && endDate != null)) {
                              showRedFlush(context, LangKeys.datePicker.tr());
                              return;
                            }

                            if (startDate != null &&
                                endDate != null &&
                                endDate!.isBefore(startDate!)) {
                              showRedFlush(context, LangKeys.dateBefore.tr());
                              return;
                            }

                            final param = RequestParameters(
                              branch: selectedBranch,
                              startDate: startDate,
                              endDate: endDate,
                            );

                            Navigator.pop(context, param);
                          },
                          child: Text(
                            'تم',
                            style: Styles.textStyle20.copyWith(
                              color: color.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state.status == BranchStatus.loading) {
          return const Center(
            child: SpinKitFadingCircle(color: Colors.blue, size: 60),
          );
        } else if (state.status == BranchStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage ?? 'حدث خطأ ما',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDatePicked,
  }) {
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: color.primary,
                onPrimary: Colors.white,
                onSurface: Colors.black87,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: color.primary),
              ),
            ),
            child: child!,
          ),
        );

        if (picked != null) onDatePicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.primary.withOpacity(0.8), color.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.date_range, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedDate != null
                    ? '${selectedDate.toLocal().toString().split(' ')[0]}'
                    : label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

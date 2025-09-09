import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../main_bills/domain/entity/Bills_entity.dart';
import '../../../../../main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import '../../../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';

class TextFieldBillsID extends StatefulWidget {
  const TextFieldBillsID({
    super.key,
    required TextEditingController billsCtrl,
    required this.colorScheme,
    this.onSelected,
  }) : _billsCtrl = billsCtrl;

  final TextEditingController _billsCtrl;
  final ColorScheme colorScheme;
  final void Function(int)? onSelected;

  @override
  State<TextFieldBillsID> createState() => _TextFieldBillsIDState();
}

class _TextFieldBillsIDState extends State<TextFieldBillsID> {
  bool hasFetched = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        final value = val?.trim() ?? '';

        if (value.isEmpty) return 'من فضلك أدخل هذا الحقل';

      },
      onTap: () async {
        final cubit = BlocProvider.of<BillsCubit>(context);

        if (!hasFetched) {
          // ✅ افتح اللودر
          showDialog(
            context: context,
            barrierDismissible: false, // ممنوع يتقفل إلا بالكود
            builder: (_) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue, // غير اللون زي ما تحب
                  size: 60,
                ),
              );
            },
          );

          await cubit.fetchActiveBills(FetchBillsParam(branch: ['all']));
          hasFetched = true;

          // ✅ اقفل اللودر بعد التحميل
          Navigator.of(context, rootNavigator: true).pop();
        }

        final state = cubit.state;
        if (state.status == BillsStatus.activeSuccess) {
          final selectedBills = await showModalBottomSheet<BillsEntity>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  List<BillsEntity> filteredSchools = List.from(state.bills);
                  final TextEditingController searchCtrl =
                      TextEditingController();
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // 🔍 البحث
                            TextField(
                              controller: searchCtrl,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: LangKeys.search.tr(),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (query) {
                                setState(() {
                                  filteredSchools = state.bills
                                      .where(
                                        (bills) =>
                                            (bills.children?[0].name ?? '')
                                                .toLowerCase()
                                                .contains(query.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            // 📋 القائمة
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount: filteredSchools.length,
                                itemBuilder: (context, index) {
                                  final school = filteredSchools[index];
                                  return ListTile(
                                    title: Text(
                                      school.children?[0].name ?? 'لا يوجد اسم',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    leading: Icon(
                                      Icons.school,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    onTap: () => Future.microtask(
                                      () => Navigator.pop(context, school),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
          // selectedBills.children?[1].name ??
          // ✅ بعد الاختيار
          if (selectedBills != null) {
            widget._billsCtrl.text = selectedBills.children?[0].name ?? '';
            widget.onSelected!(selectedBills.id);
          }
        }
      },
      readOnly: true,
      controller: widget._billsCtrl,
      maxLines: 1,
      style: TextStyle(color: widget.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: LangKeys.bills.tr(),
        labelStyle: TextStyle(color: widget.colorScheme.onSurface),
        prefixIcon: Icon(Icons.school, color: widget.colorScheme.onSurface),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}

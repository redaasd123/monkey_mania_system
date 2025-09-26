import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';

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
          await cubit.fetchActiveBills(FetchBillsParam(branch: [AuthHelper.getBranch()]));
          hasFetched = true;

          Navigator.of(context, rootNavigator: true).pop();
        }

        final state = cubit.state;
        final selectedBills = await showModalBottomSheet<BillsEntity>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent, // نستخدم Container داخلي للثيم
          builder: (_) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                List<BillsEntity> filteredSchools = List.from(state.bills);
                final TextEditingController searchCtrl = TextEditingController();
                final colorScheme = Theme.of(context).colorScheme;

                return StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, -6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // 🔹 Handle
                          Container(
                            width: 50,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurface.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          // 🔹 بحث
                          TextField(
                            controller: searchCtrl,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: LangKeys.search.tr(),
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (query) {
                              setState(() {
                                filteredSchools = state.bills.where((bill) {
                                  // اتأكد إن فيه أطفال قبل الوصول لأول عنصر
                                  if (bill.children == null || bill.children!.isEmpty) return false;

                                  final name = bill.children![0].name ?? '';
                                  return name.toLowerCase().contains(query.toLowerCase());
                                }).toList();
                              });
                            },

                          ),

                          const SizedBox(height: 12),

                          // 🔹 قائمة الكروت
                          Expanded(
                            child: ListView.separated(
                              controller: scrollController,
                              itemCount: filteredSchools.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final school = filteredSchools[index];

                                // لو القائمة فارغة او مفيش أطفال
                                if (school.children == null || school.children!.isEmpty) {
                                  return const SizedBox.shrink(); // أو Container مع رسالة "لا يوجد بيانات"
                                }

                                final childName = school.children![0].name ?? 'لا يوجد اسم';

                                return InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => Navigator.pop(context, school),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          colorScheme.primary.withOpacity(0.85),
                                          colorScheme.primary.withOpacity(0.6),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: colorScheme.secondary.withOpacity(0.2),
                                          child: Icon(Icons.school, color: colorScheme.onPrimary),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            childName,
                                            style: TextStyle(
                                              color: colorScheme.onPrimary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: colorScheme.onPrimary.withOpacity(0.7),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },

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

// بعد الاختيار
        if (selectedBills != null) {
          widget._billsCtrl.text = selectedBills.children?[0].name ?? '';
          widget.onSelected!(selectedBills.id);
        }

      },
      readOnly: true,
      controller: widget._billsCtrl,
      maxLines: 1,
      style: TextStyle(color: widget.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: LangKeys.bills.tr(),
        labelStyle: TextStyle(color: Colors.teal,),
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

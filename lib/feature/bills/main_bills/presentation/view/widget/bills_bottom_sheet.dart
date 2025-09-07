import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/create_bills_param.dart';
import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';

import '../../../../../../core/utils/constans.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../children/domain/param/fetch_children_param.dart';
import '../../../../../children/presentation/manager/cubit/children_state.dart';
import 'new_children_field.dart';

class BillsBottomSheet extends StatefulWidget {
  final String title;
  final ChildrenEntity? childrenEntity;

  const BillsBottomSheet({super.key, required this.title, this.childrenEntity});

  @override
  State<BillsBottomSheet> createState() => _BillsBottomSheetState();
}

class _BillsBottomSheetState extends State<BillsBottomSheet> {
  final promoCode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  /////
  final _nameCtrl = TextEditingController();
  final _childrenCtrl = TextEditingController();
  List<int>? _selectedChildrenId;
  int? _selectedBranchId;

  final _branchCtrl = TextEditingController();
  List<Map<String, dynamic>> children = [];
  final _relations = ['father', 'mother', 'sibling', 'other'];

  List<NewChildField> childrenFields = [NewChildField()];

  void _submit() {
    print('🟡 Submit pressed');

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedChildrenId == null) {
      print('🔴 selectedChildrenId is null');
      showRedFlush(context, LangKeys.nameRequired.tr());
      return;
    }

    print('✅ Passed validation');

    List<NewChildren> newChildren = children.map((child) {
      print('📦 Child: $child');
      return NewChildren(
        name: child['name'],
        dateBirth: child['birthDate'],
        phoneNumber: (child['phones'] as List).map((phone) {
          print('📞 Phone: $phone');
          return PhoneNumber(
            value: phone['value'],
            relationship: phone['relationship'],
          );
        }).toList(),
      );
    }).toList();

    final param = CreateBillsParam(
      discount: '"test-promo-percentage"',
      childrenId: _selectedChildrenId!,
      newChildren: newChildren,
      branch: _selectedBranchId!,
    );

    print('✅ PARAM CREATED: $param');
    Navigator.pop(context, param);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer,
                colorScheme.primary.withOpacity(0.8),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHandle(),
                  _buildHeader(colorScheme),
                  const SizedBox(height: 20),
                  _buildForm(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandle() => Center(
    child: Container(
      width: 48,
      height: 4,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  Widget _buildHeader(ColorScheme colorScheme) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(kTest),
        ),
        const SizedBox(width: 12),
        Text(
          widget.title,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldChildrenID(
              childrenCtrl: _childrenCtrl,
              colorScheme: Theme.of(context).colorScheme,
              onSelected: (List<num> ids) {
                print("Selected Children IDs: $ids");
                List<int> selectedChildrenIds = ids
                    .map((e) => e as int)
                    .toList();
                _selectedChildrenId = selectedChildrenIds;
              },
            ),

            const SizedBox(height: 12),
            _buildBranchField(),
            const SizedBox(height: 12),
            _buildField(promoCode, 'PromoCode', Icons.discount),
            const SizedBox(height: 12),
            ..._buildChildrenFields(),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  children.add({
                    'name': '',
                    'birthDate': '',
                    'phones': [
                      {'value': '', 'relationship': _relations.first},
                    ],
                  });
                });
              },
              icon: const Icon(Icons.add),
              label: Text(LangKeys.addChild.tr()),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submit,
                child: Text(LangKeys.save.tr(), style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchField() {
    return TextFormField(
      validator: _validate,
      controller: _branchCtrl,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'branch',
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final cubit = BlocProvider.of<BranchCubit>(context);
        await cubit.fetchBranch();
        final state = cubit.state;

        if (state is BranchSuccessState) {
          print("✅ BranchSuccessState found");
          final selectBranch = await showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            isScrollControlled: true,
            builder: (context) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.branch.length,
                itemBuilder: (context, index) {
                  final branch = state.branch[index];
                  return ListTile(
                    title: Text(branch.name ?? ''),
                    onTap: () {
                      print("Tapped!");
                      Navigator.pop(context, branch);
                    },
                  );
                },
              );
            },
          );

          if (selectBranch != null) {
            _branchCtrl.text = selectBranch.product ?? '';
            _selectedBranchId =
                selectBranch.id; // احفظ الـ ID لاستخدامه في param
            print("🟢 Selected Branch ID: $_selectedBranchId");
          }
        }
      },
    );
  }

  ///////////////////////////////////

  Widget _buildField(
    TextEditingController? controller,
    String label,
    IconData icon, {
    // String? validatorMsg,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      //controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        prefixIcon: Icon(icon, color: colorScheme.onSurface),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
    );
  }

  List<Widget> _buildChildrenFields() {
    return List.generate(children.length, (childIndex) {
      final child = children[childIndex];
      final phones = child['phones'] as List<Map<String, String>>;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'طفل ${childIndex + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        children.removeAt(childIndex);
                      });
                    },
                  ),
                ],
              ),

              // اسم الطفل
              TextFormField(
                validator: _validate,
                initialValue: child['name'],
                decoration: const InputDecoration(labelText: 'الاسم'),
                onChanged: (val) => children[childIndex]['name'] = val,
              ),
              const SizedBox(height: 8),

              // تاريخ الميلاد
              TextFormField(
                validator: _validate,
                readOnly: true,
                controller: TextEditingController(
                  text: children[childIndex]['birthDate'],
                ),
                decoration: const InputDecoration(labelText: 'تاريخ الميلاد'),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      // خزِّن التاريخ بصيغة 2024-5-30 بدون أصفار زائدة
                      final formattedDate = DateFormat(
                        'y-M-d',
                      ).format(pickedDate);
                      children[childIndex]['birthDate'] = _toEnglishDigits(
                        formattedDate,
                      );
                    });
                  }
                },
              ),

              const SizedBox(height: 8),

              ...List.generate(phones.length, (phoneIndex) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            validator: _validate,
                            initialValue: phones[phoneIndex]['value'],
                            decoration: const InputDecoration(
                              labelText: 'رقم الهاتف',
                              counterText: '', // إخفاء عداد الحروف
                            ),
                            keyboardType: TextInputType.phone,
                            // 👈 يظهر لوحة أرقام
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // 👈 يسمح بالأرقام فقط
                              LengthLimitingTextInputFormatter(11),
                            ],
                            onChanged: (val) =>
                                phones[phoneIndex]['value'] = val,
                          ),
                        ),
                        const SizedBox(width: 8),

                        // العلاقة
                        Expanded(
                          flex: 4,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: phones[phoneIndex]['relationship'],
                            items: _relations
                                .map(
                                  (r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                phones[phoneIndex]['relationship'] = val!;
                              });
                            },
                            decoration:  InputDecoration(
                              labelText: LangKeys.relationShip.tr(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),

                        // زر حذف رقم الهاتف
                        SizedBox(
                          width: 40,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                if (phoneIndex >= 1) {
                                  phones.removeAt(phoneIndex);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }),

              // زر إضافة رقم هاتف جديد للطفل
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      phones.add({
                        'value': '',
                        'relationship': _relations.first,
                      });
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('رقم إضافي'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TextFieldChildrenID extends StatefulWidget {
  const TextFieldChildrenID({
    super.key,
    required TextEditingController childrenCtrl,
    required this.colorScheme,
    this.onSelected,
  }) : _childCtrl = childrenCtrl;

  final TextEditingController _childCtrl;
  final ColorScheme colorScheme;
  final void Function(List<num>)? onSelected;

  @override
  State<TextFieldChildrenID> createState() => _TextFieldChildrenIDState();
}

class _TextFieldChildrenIDState extends State<TextFieldChildrenID> {
  bool hasFetched = false;
  List<int> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      onTap: () async {
        final cubit = BlocProvider.of<ChildrenCubit>(context);
        if (!hasFetched) {
          await cubit.fetchChildren(FetchChildrenParam());
          hasFetched = true;
        }

        final state = cubit.state;
        if (state.status==ChildrenStatus.success) {
          final result = await showModalBottomSheet<List<ChildrenEntity>>(
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
                  List<ChildrenEntity> filteredChildren = List.from(
                    state.allChildren,
                  );
                  final TextEditingController searchCtrl =
                      TextEditingController();
                  List<ChildrenEntity> selectedChildren = [];
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // 🔍 حقل البحث
                            TextField(
                              controller: searchCtrl,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: LangKeys.children.tr(),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (query) {
                                setState(() {
                                  filteredChildren = state.allChildren
                                      .where(
                                        (children) => (children.name ?? '')
                                            .toLowerCase()
                                            .contains(query.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount: filteredChildren.length,
                                itemBuilder: (context, index) {
                                  final child = filteredChildren[index];
                                  final isSelected = selectedChildren.any(
                                    (e) => e.id == child.id,
                                  );
                                  return ListTile(
                                    title: Text(
                                      child.name ?? 'لا يوجد اسم',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    trailing: isSelected
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          )
                                        : const Icon(Icons.circle_outlined),
                                    leading: Icon(
                                      Icons.child_care_sharp,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          selectedChildren.removeWhere(
                                            (e) => e.id == child.id,
                                          );
                                        } else {
                                          selectedChildren.add(child);
                                        }
                                      });
                                    },
                                  );
                                },

                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, selectedChildren);
                              },
                              child: Text('تأكيد الاختيار'),
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

          // ✅ بعد الاختيار
          if (result != null && result.isNotEmpty) {
            final names = result.map((e) => e.name).join(', ');
            final ids = result.map((e) => e.id).whereType<num>().toList();
            widget.onSelected?.call(ids);
            widget._childCtrl.text = names;
          }
        }
      },

      readOnly: true,
      controller: widget._childCtrl,
      maxLines: 1,
      style: TextStyle(color: widget.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: LangKeys.children.tr(),
        labelStyle: TextStyle(color: widget.colorScheme.onSurface),
        prefixIcon: Icon(
          Icons.child_care_sharp,
          color: widget.colorScheme.onSurface,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}

String _toEnglishDigits(String input) {
  const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  for (int i = 0; i < arabicNumbers.length; i++) {
    input = input.replaceAll(arabicNumbers[i], englishNumbers[i]);
  }
  return input;
}

String? _validate(String? value) {
  if (value == null || value.trim().isEmpty) return LangKeys.nameRequired.tr();
}

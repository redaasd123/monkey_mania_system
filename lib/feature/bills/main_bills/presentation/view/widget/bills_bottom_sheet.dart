import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_build_header_sheet_.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/domain/entity/children/non_active.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';

import '../../../../../../core/helper/auth_helper.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../children/domain/param/fetch_children_param.dart';
import '../../../../../children/presentation/manager/cubit/children_state.dart';
import '../../../domain/use_case/param/create_bills_param.dart';
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
  final _childrenCtrl = TextEditingController();
  List<int>? _selectedChildrenId;
  List<Map<String, dynamic>> children = [];
  final _relations = ['father', 'mother', 'sibling', 'other'];
  List<NewChildField> childrenFields = [NewChildField()];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHandle(),
              CustombuildHeader(
                colorScheme,
                widget.title,
                colorScheme.onPrimary,
              ),
              const SizedBox(height: 20),
              _buildForm(context),
            ],
          ),
        ),
      ),
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
              colorScheme: colorScheme,
              onSelected: (List<num> ids) {
                _selectedChildrenId = ids.map((e) => e as int).toList();
              },
            ),
            const SizedBox(height: 12),
            _buildField(promoCode, LangKeys.promoCode.tr(), Icons.discount),
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
              child: CustomButton(
                text: LangKeys.save.tr(),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  if (_selectedChildrenId == null) {
                    showRedFlush(context, LangKeys.nameRequired.tr());
                    return;
                  }

                  List<NewChildren> newChildren = children.map((child) {
                    return NewChildren(
                      name: child['name'],
                      dateBirth: child['birthDate'],
                      phoneNumber: (child['phones'] as List).map((phone) {
                        return PhoneNumber(
                          value: phone['value'],
                          relationship: phone['relationship'],
                        );
                      }).toList(),
                    );
                  }).toList();

                  final branch = AuthHelper.getBranch();
                  final param = CreateBillsParam(
                    discount: promoCode.text,
                    childrenId: _selectedChildrenId!,
                    newChildren: newChildren,
                    branch: branch!,
                  );

                  Navigator.pop(context, param);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController? controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        children.removeAt(childIndex);
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                validator: _validate,
                initialValue: child['name'],
                decoration: InputDecoration(labelText: LangKeys.name.tr()),
                onChanged: (val) => children[childIndex]['name'] = val,
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: _validate,
                readOnly: true,
                controller: TextEditingController(
                  text: children[childIndex]['birthDate'],
                ),
                decoration: InputDecoration(
                  labelText: LangKeys.dateOfBirth.tr(),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      children[childIndex]['birthDate'] = _toEnglishDigits(
                        DateFormat('y-M-d').format(pickedDate),
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
                            decoration: InputDecoration(
                              labelText: LangKeys.phoneNumber.tr(),
                              counterText: '',
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            onChanged: (val) =>
                                phones[phoneIndex]['value'] = val,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                            decoration: InputDecoration(
                              labelText: LangKeys.relationShip.tr(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 40,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                if (phoneIndex >= 1)
                                  phones.removeAt(phoneIndex);
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
                  label: Text(LangKeys.addNumber.tr()),
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) return LangKeys.nameRequired.tr();
        return null;
      },
      onTap: () async {
        final cubit = BlocProvider.of<ChildrenCubit>(context);
        if (!hasFetched) {
          await cubit.childrenNonActive(FetchChildrenParam());
          hasFetched = true;
        }

        final state = cubit.state;
        if (state.status == ChildrenStatus.nonSuccess) {
          final TextEditingController searchCtrl = TextEditingController();
          List<ChildrenNonActiveEntity> filteredChildren = List.from(state.nonActiveChildren);
          List<ChildrenNonActiveEntity> selectedChildren = [];

          final result = await showModalBottomSheet<List<ChildrenNonActiveEntity>>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.7,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF004953), Color(0xFF004953)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 5,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Text(
                                LangKeys.selectChildren.tr(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: searchCtrl,
                                style: const TextStyle(color: Colors.white),
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.15),
                                  hintText: LangKeys.search.tr(),
                                  hintStyle: const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (query) {
                                  setState(() {
                                    filteredChildren = state.nonActiveChildren
                                        .where(
                                          (children) => (children.name ?? '')
                                          .toLowerCase()
                                          .contains(query.toLowerCase()),
                                    )
                                        .toList();
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: filteredChildren.length,
                                  itemBuilder: (context, index) {
                                    final child = filteredChildren[index];
                                    final isSelected = selectedChildren.any(
                                          (e) => e.id == child.id,
                                    );

                                    return Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(12),
                                        leading: CircleAvatar(
                                          backgroundColor: isSelected
                                              ? Colors.green
                                              : const Color(0xFF004953),
                                          child: const Icon(Icons.child_care, color: Colors.white),
                                        ),
                                        title: Text(
                                          child.name ?? 'لا يوجد اسم',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: Icon(
                                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                                          color: isSelected ? Colors.green : Colors.grey,
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      backgroundColor: const Color(0xFFF4EDF6),
                                      foregroundColor: Colors.white,
                                      elevation: 6,
                                    ),
                                    onPressed: () => Navigator.pop(context, selectedChildren),
                                    child: Text(
                                      LangKeys.save.tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );

          if (result != null && result.isNotEmpty) {
            final names = result.map((e) => e.name).join(', ');
            final ids = result.map((e) => e.id).whereType<int>().toList();
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
  for (int i = 0; i < arabicNumbers.length; i++)
    input = input.replaceAll(arabicNumbers[i], englishNumbers[i]);
  return input;
}

String? _validate(String? value) {
  if (value == null || value.trim().isEmpty) return LangKeys.nameRequired.tr();
}

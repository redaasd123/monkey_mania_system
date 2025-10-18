import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/bottom_sheet_button.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

import '../../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/selected_item_text_field.dart';
import '../../../../../core/widget/widget/custom_build_header_sheet_.dart';
import '../../../../school/domain/entity/school_entity.dart';

class AddChildBottomSheet extends StatefulWidget {
  final String title;
  final ChildrenEntity? childrenEntity;

  const AddChildBottomSheet({
    super.key,
    required this.title,
    this.childrenEntity,
  });

  @override
  State<AddChildBottomSheet> createState() => _AddChildBottomSheetState();
}

class _AddChildBottomSheetState extends State<AddChildBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _birthDateCtrl = TextEditingController();
  final _addrCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _schoolCtrl = TextEditingController();
  int? _selectedSchoolId;
  List<Map<String, String>> phoneNumbers = [];

  final _relations = ['father', 'mother', 'sibling', 'other'];

  @override
  void initState() {
    super.initState();
    if (widget.childrenEntity != null) {
      _selectedSchoolId = widget.childrenEntity!.school;
      _schoolCtrl.text = widget.childrenEntity!.name?.toString() ?? '';
      _nameCtrl.text = widget.childrenEntity!.name ?? '';
      _birthDateCtrl.text = widget.childrenEntity!.birthDate ?? '';
      _addrCtrl.text = widget.childrenEntity!.address ?? '';
      _notesCtrl.text = widget.childrenEntity!.notes ?? '';
      phoneNumbers =
          widget.childrenEntity?.childPhoneNumbersSet
              ?.map(
                (e) => {
                  'value': e.phoneNumber ?? '',
                  'relationship': e.relationship ?? 'father',
                },
              )
              .toList() ??
          [];
    } else {
      phoneNumbers.add({'value': '', 'relationship': _relations.first});
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _birthDateCtrl.dispose();
    _addrCtrl.dispose();
    _notesCtrl.dispose();
    _schoolCtrl.dispose();
    super.dispose();
  }

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
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              24, // 👈 moves up with keyboard
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHandle(),
              CustombuildHeader(colorScheme, LangKeys.appName.tr(), colorScheme.onPrimary),
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
            _buildField(
              _nameCtrl,
              LangKeys.name.tr(),
              Icons.person,
              LangKeys.nameRequired.tr(),
            ),
            const SizedBox(height: 12),
            _buildDateField(),
            const SizedBox(height: 12),
            _buildAddressField(),
            const SizedBox(height: 12),

            SelectItemTextField<SchoolEntity>(
              controller: _schoolCtrl,
              colorScheme: Theme.of(context).colorScheme,
              label: LangKeys.school.tr(),
              fetchItems: () async {
                await context.read<SchoolCubit>().fetchSchool();
                return context.read<SchoolCubit>().state.allSchool;
              },
              itemTitle: (school) => school.name ?? 'لا يوجد اسم',
              onSelected: (school) {
                _selectedSchoolId = school.id;
              },
            ),

            const SizedBox(height: 12),
            _buildField(
              _notesCtrl,
              LangKeys.notes.tr(),
              Icons.note_alt,
              null,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            ..._buildPhoneNumberFields(),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  phoneNumbers.add({
                    'value': '',
                    'relationship': _relations.first,
                  });
                });
              },
              icon: const Icon(Icons.add),
              label: Text(LangKeys.addNumber.tr()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomButtomSheetButton(
                text: LangKeys.save.tr(),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final childParam = CreateChildrenParam(
                      school: _selectedSchoolId,
                      name: _nameCtrl.text.trim(),
                      birthDate: _birthDateCtrl.text.trim(),
                      address: _addrCtrl.text.trim(),
                      notes: _notesCtrl.text.trim().isEmpty
                          ? null
                          : _notesCtrl.text.trim(),
                      phones: phoneNumbers
                          .map(
                            (e) => {
                              'value': (e['value'] ?? '').toString().trim(),
                              'relationship': (e['relationship'] ?? 'father')
                                  .toString(),
                            },
                          )
                          .toList(),
                    );

                    Navigator.pop(context, childParam);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _birthDateCtrl,
      readOnly: true,
      decoration: InputDecoration(
        labelText: LangKeys.dateOfBirth.tr(),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          _birthDateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      },
      validator: _validateBirthDate,
    );
  }

  ///////////////////////////////////
  Widget _buildAddressField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.trim().isEmpty)
          return LangKeys.nameRequired.tr();
      },
      controller: _addrCtrl,
      readOnly: true,
      decoration: InputDecoration(
        labelText: LangKeys.address.tr(),
        prefixIcon: Icon(Icons.location_on),
      ),
      onTap: () async {
        final selected = await showModalBottomSheet<String>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => _buildAddressSelector(),
        );
        if (selected != null) {
          _addrCtrl.text = selected;
        }
      },
    );
  }

  Widget _buildAddressSelector() {
    final allAreas = [
      'الصعيدي القديم',
      'منطقة النوادي',
      'الحي الثالث',
      'الصعيدي الجديد',
      'المنطقة المركزية',
    ];
    final searchCtrl = TextEditingController();
    List<String> filteredAreas = List.from(allAreas);

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF004953), // Indigo Violet
                Color(0xFF004953),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔘 Handle
                  Container(
                    width: 60,
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),

                  // 🏷️
                  Text(
                    LangKeys.address.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: searchCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                      hintText: LangKeys.address.tr(),
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) => setState(() {
                      filteredAreas = allAreas
                          .where(
                            (area) => area.toLowerCase().contains(
                              val.trim().toLowerCase(),
                            ),
                          )
                          .toList();
                    }),
                  ),
                  const SizedBox(height: 16),

                  ...filteredAreas.map(
                    (area) => Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF004953),
                          child: const Icon(
                            Icons.location_city_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          area,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                        onTap: () => Navigator.pop(context, area),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade400,
                        child: const Icon(
                          Icons.edit_location_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        LangKeys.enterAddressManually.tr(),
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        final manualAddress = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            final manualCtrl = TextEditingController();
                            return AlertDialog(
                              title: Text(LangKeys.enterAddressManually.tr()),
                              content: TextField(
                                controller: manualCtrl,
                                decoration: const InputDecoration(
                                  hintText:
                                      'مثال: خلف الجامعة - بجوار كلية العلوم',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(LangKeys.cansel.tr()),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, manualCtrl.text),
                                  child: Text(LangKeys.ok.tr()),
                                ),
                              ],
                            );
                          },
                        );

                        if (manualAddress != null &&
                            manualAddress.trim().isNotEmpty) {
                          Navigator.pop(context, manualAddress.trim());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///////////////////////////////
  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon,
    String? validatorMsg, {
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
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
      validator: validatorMsg == null
          ? null
          : (v) => v == null || v.trim().isEmpty ? validatorMsg : null,
    );
  }

  List<Widget> _buildPhoneNumberFields() {
    return List.generate(phoneNumbers.length, (index) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  cursorColor: Colors.red,
                  initialValue: phoneNumbers[index]['value'],
                  decoration: InputDecoration(
                    labelText: LangKeys.phoneNumber.tr(),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onChanged: (val) => phoneNumbers[index]['value'] = val,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty)
                      return LangKeys.nameRequired.tr();
                    if (val.trim().length != 11)
                      return 'يجب إدخال 11 رقمًا بالضبط';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: phoneNumbers[index]['relationship'],
                  items: _relations
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (val) => setState(
                    () => phoneNumbers[index]['relationship'] = val!,
                  ),
                  decoration: InputDecoration(
                    labelText: LangKeys.relation.tr(),
                  ),
                ),
              ),
              const SizedBox(width: 1),
              SizedBox(
                width: 40,
                height: 58,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (phoneNumbers.length > 1) {
                      setState(() => phoneNumbers.removeAt(index));
                    } else {}
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      );
    });
  }

  String? _validateBirthDate(String? value) {
    if (value == null || value.trim().isEmpty)
      return LangKeys.nameRequired.tr();
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value.trim());
      return null;
    } catch (_) {}
  }
}

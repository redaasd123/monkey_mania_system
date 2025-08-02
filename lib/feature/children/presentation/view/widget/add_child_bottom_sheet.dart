import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monkey_app/core/funcation/show_snack_bar.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../school/data/model/school_model.dart';
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedSchoolId == null) {
        showSnackBar(context, LangKeys.nameRequired.tr());
        return;
      }

      final childParam = CreateChildrenParam(
        school: _selectedSchoolId!,
        name: _nameCtrl.text.trim(),
        birthDate: _birthDateCtrl.text.trim(),
        address: _addrCtrl.text.trim(),
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        phones: phoneNumbers
            .map(
              (e) => {
                'value': (e['value'] ?? '').toString().trim(),
                'relationship': (e['relationship'] ?? 'father').toString(),
              },
            )
            .toList(),
      );

      Navigator.pop(context, childParam);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
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
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHandle(),
                _buildHeader(colorScheme),
                const SizedBox(height: 20),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
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
            _buildField(_nameCtrl, LangKeys.name.tr(), Icons.person, LangKeys.nameRequired.tr()),
            const SizedBox(height: 12),
            _buildDateField(),
            const SizedBox(height: 12),
            _buildAddressField(),
            const SizedBox(height: 12),
            TextFieldSchoolID(
              schoolCtrl: _schoolCtrl,
              colorScheme: Theme.of(context).colorScheme,
              onSelected: (int id) {
                _selectedSchoolId = id;
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
              label:  Text(LangKeys.addNumber.tr()),
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
                child:  Text(LangKeys.save.tr(), style: TextStyle(fontSize: 18)),
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
      decoration:  InputDecoration(
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
      controller: _addrCtrl,
      readOnly: true,
      decoration:  InputDecoration(
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
      validator: (val) => val == null || val.trim().isEmpty ? LangKeys.nameRequired.tr() : null,
    );
  }

  Widget _buildAddressSelector() {
    final allAreas = [
      ' الصعيدي القديم',
      'منطقة النوادي',
      'الحي الثالث',
      'الصعيدي الجديد ',
      'المنطقة المركزية',
    ];
    final searchCtrl = TextEditingController();
    List<String> filteredAreas = List.from(allAreas);

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                  LangKeys.address.tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: searchCtrl,
                  decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: LangKeys.address.tr(),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => setState(() {
                    filteredAreas = allAreas
                        .where((area) => area.contains(val.trim()))
                        .toList();
                  }),
                ),
                const SizedBox(height: 12),
                ...filteredAreas.map(
                  (area) => Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.location_city_outlined),
                        title: Text(area),
                        onTap: () => Navigator.pop(context, area),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.edit_location_alt_outlined),
                  title:  Text(LangKeys.enterAddressManually.tr()),
                  onTap: () async {
                    final manualAddress = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        final manualCtrl = TextEditingController();
                        return AlertDialog(
                          title:  Text(LangKeys.enterAddressManually.tr()),
                          content: TextField(
                            controller: manualCtrl,
                            decoration: const InputDecoration(
                              hintText: 'مثال: خلف الجامعة - بجوار كلية العلوم',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child:  Text(LangKeys.cansel.tr()),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, manualCtrl.text),
                              child:  Text(LangKeys.ok.tr()),
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
              ],
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
//: تُستخدم لإنشاء عدد من العناصر حسب عدد العناصر داخل phoneNumbers.
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
                  decoration:  InputDecoration(labelText: LangKeys.phoneNumber.tr()),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onChanged: (val) => phoneNumbers[index]['value'] = val,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return LangKeys.nameRequired.tr();
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
                  decoration:  InputDecoration(labelText: LangKeys.relation.tr()),
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
                    } else {

                    }
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
    if (value == null || value.trim().isEmpty) return LangKeys.nameRequired.tr();
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value.trim());
      return null;
    } catch (_) {
    }
  }
}

class TextFieldSchoolID extends StatefulWidget {
  const TextFieldSchoolID({
    super.key,
    required TextEditingController schoolCtrl,
    required this.colorScheme,
    this.onSelected,
  }) : _schoolCtrl = schoolCtrl;

  final TextEditingController _schoolCtrl;
  final ColorScheme colorScheme;
  final void Function(int)? onSelected;

  @override
  State<TextFieldSchoolID> createState() => _TextFieldSchoolIDState();
}

class _TextFieldSchoolIDState extends State<TextFieldSchoolID> {
  bool hasFetched = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        final cubit = BlocProvider.of<SchoolCubit>(context);
        if (!hasFetched) {
          await cubit.fetchSchool();
          hasFetched = true;
        }

        final state = cubit.state;
        if (state is SchoolSuccessState) {
          final selectedSchool = await showModalBottomSheet<SchoolEntity>(
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
                  List<SchoolEntity> filteredSchools = List.from(state.schools);
                  final TextEditingController searchCtrl =
                      TextEditingController();

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
                                hintText: LangKeys.search.tr(),
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
                                  filteredSchools = state.schools
                                      .where(
                                        (school) => (school.name ?? '')
                                            .toLowerCase()
                                            .contains(query.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            // 📋 قائمة المدارس القابلة للتمرير
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount: filteredSchools.length,
                                itemBuilder: (context, index) {
                                  final school = filteredSchools[index];
                                  return ListTile(
                                    title: Text(
                                      school.name ?? 'لا يوجد اسم',
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
                                    onTap: () => Future.microtask(() => Navigator.pop(context,school))
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

          // ✅ بعد الاختيار
          if (selectedSchool != null) {
            widget._schoolCtrl.text = selectedSchool.name ?? '';
            widget.onSelected!(selectedSchool.id); // ترجع الـ ID
          }
        }
      },

      readOnly: true,
      validator: (val) {
        if (val == null) {
          return LangKeys.nameRequired.tr();
        }
      },
      controller: widget._schoolCtrl,
      maxLines: 1,
      style: TextStyle(color: widget.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: LangKeys.school.tr(),
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

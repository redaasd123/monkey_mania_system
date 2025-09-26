import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

import '../../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/selected_item_text_field.dart';
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

  //flutter pub run build_runner build --delete-conflicting-outputs
  void _submit() {
    if (_formKey.currentState!.validate()) {
      // if (_selectedSchoolId == null) {
      //  showRedFlush(context, LangKeys.nameRequired.tr());
      //   return;
      // }

      final childParam = CreateChildrenParam(
        school: _selectedSchoolId,
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
            mainAxisSize: MainAxisSize.min, // 👈 takes only needed space
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
              controller: _schoolCtrl, // نفس الـ controller اللي كنت مستخدمه
              colorScheme: Theme.of(context).colorScheme,
              label: LangKeys.school.tr(),
              fetchItems: () async {
                // هنا نستدعي الـ Cubit نفسه اللي كنت بتسحب منه المدارس
                await context.read<SchoolCubit>().fetchSchool();
                return context.read<SchoolCubit>().state.allSchool;
              },
              itemTitle: (school) => school.name ?? 'لا يوجد اسم', // طريقة عرض الاسم
              onSelected: (school) {
                _selectedSchoolId = school.id; // نفس المنطق القديم
                print('Selected school ID: $_selectedSchoolId');
              },
            ),


            // TextFieldSchoolID(
            //   childrenCtrl: _schoolCtrl,
            //   colorScheme: Theme.of(context).colorScheme,
            //   onSelected: (int id) {
            //     _selectedSchoolId = id;
            //   },
            // ),
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
                Color(0xFF5A55CA), // Indigo Violet
                Color(0xFF9D84FF),
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

                  // 🏷️ العنوان
                  Text(
                    LangKeys.address.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 🔍 صندوق البحث
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

                  // 📋 قائمة المناطق
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
                          backgroundColor: Colors.deepPurple.shade400,
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

                  // ✍️ زر الإدخال اليدوي
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

class TextFieldSchoolID extends StatefulWidget {
  const TextFieldSchoolID({
    super.key,
    required TextEditingController childrenCtrl,
    required this.colorScheme,
    this.onSelected,
  }) : _schoolCtrl = childrenCtrl;

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
        if (state.status == SchoolStatus.success) {
          final selectedSchool = await showModalBottomSheet<SchoolEntity>(
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
                  List<SchoolEntity> filteredSchools = List.from(
                    state.allSchool,
                  );
                  final TextEditingController searchCtrl =
                      TextEditingController();

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF5A55CA), Color(0xFF9D84FF)],
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
                              // 🔘 Handle
                              Container(
                                width: 50,
                                height: 5,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              // 🏫 العنوان
                              Text(
                                "اختر المدرسة",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // 🔍 البحث
                              TextField(
                                controller: searchCtrl,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.15),
                                  hintText: "ابحث عن مدرسة...",
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white70,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (query) {
                                  setState(() {
                                    filteredSchools = state.allSchool
                                        .where(
                                          (school) => (school.name ?? '')
                                              .toLowerCase()
                                              .contains(query.toLowerCase()),
                                        )
                                        .toList();
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // 📋 قائمة المدارس
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: filteredSchools.length,
                                  itemBuilder: (context, index) {
                                    final school = filteredSchools[index];

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
                                        contentPadding: const EdgeInsets.all(
                                          12,
                                        ),
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              Colors.indigo.shade400,
                                          child: const Icon(
                                            Icons.school,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(
                                          school.name ?? 'لا يوجد اسم',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onTap: () => Future.microtask(
                                          () => Navigator.pop(context, school),
                                        ),
                                      ),
                                    );
                                  },
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


































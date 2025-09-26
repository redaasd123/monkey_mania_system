import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/langs_key.dart';

import '../../../domain/entity/school_entity.dart';

class AddSchoolBottomSheet extends StatefulWidget {
  const AddSchoolBottomSheet({
    super.key,
    required this.text,
    required this.model,
  });

  final String text;
  final SchoolEntity? model;

  @override
  State<AddSchoolBottomSheet> createState() => _AddSchoolBottomSheetState();
}

class _AddSchoolBottomSheetState extends State<AddSchoolBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addrCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.model != null) {
      _nameCtrl.text = widget.model!.name;
      _addrCtrl.text = widget.model!.address;
      _notesCtrl.text = widget.model!.notes ?? '';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addrCtrl.dispose();
    _notesCtrl.dispose();
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
          bottom: MediaQuery.of(context).viewInsets.bottom + 24, // 👈 moves up with keyboard
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

  Widget _buildHeader(ColorScheme colorScheme) => Row(
    children: [
      const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 23,
        backgroundImage: AssetImage(kTest),
      ),
      const SizedBox(width: 12),
      Text(
        LangKeys.appName.tr(),
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ],
  );

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
          children: [
            _buildField(
              context: context,
              controller: _nameCtrl,
              label: LangKeys.school.tr(),
              icon: Icons.school,
              validatorMsg: LangKeys.nameRequired.tr(),
            ),
            const SizedBox(height: 12),
            _buildField(
              context: context,
              controller: _addrCtrl,
              label: LangKeys.address.tr(),
              icon: Icons.location_on,
              validatorMsg: LangKeys.school.tr(),
            ),
            const SizedBox(height: 12),
            _buildField(
              context: context,
              controller: _notesCtrl,
              label: LangKeys.notes.tr(),
              icon: Icons.edit_note,
              maxLines: 3,
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
                child: Text(widget.text, style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final schoolParam = CreateSchoolParam(
        name: _nameCtrl.text.trim(),
        address: _addrCtrl.text.trim(),
        notes: _notesCtrl.text.trim(),
      );
      Navigator.pop(context, schoolParam);
    }
  }

  Widget _buildField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? validatorMsg,
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
}

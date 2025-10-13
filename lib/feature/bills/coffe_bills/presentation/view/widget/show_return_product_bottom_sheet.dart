import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/widget/widget/custom_build_header_sheet_.dart';

Future<void> showReturnProductBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => ReturnProductBottomSheet(),
  );
}

class ReturnProductBottomSheet extends StatefulWidget {
  const ReturnProductBottomSheet({super.key});

  @override
  State<ReturnProductBottomSheet> createState() => _ReturnProductBottomSheetState();
}
final _formKey = GlobalKey<FormState>();
final quantity = TextEditingController();
final productId = TextEditingController();
class _ReturnProductBottomSheetState extends State<ReturnProductBottomSheet> {
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
              24,
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

          ]
        ),
      ),
    );
  }
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
}


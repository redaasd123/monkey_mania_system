import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/widget/widget/custom_build_header_sheet_.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/update_calculations_param.dart';

import '../../../../../../core/utils/constans.dart';
import '../../../../../../core/utils/langs_key.dart';

class CalculationsBottomSheet extends StatefulWidget {
  const CalculationsBottomSheet({super.key});

  @override
  State<CalculationsBottomSheet> createState() =>
      _CalculationsBottomSheetState();
}

class _CalculationsBottomSheetState extends State<CalculationsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final priceCtrl = TextEditingController();
  final visaCtrl = TextEditingController();
  final cashCtrl = TextEditingController();
  final instapayCtrl = TextEditingController();

  @override
  void dispose() {
    visaCtrl.dispose();
    cashCtrl.dispose();
    instapayCtrl.dispose();
    priceCtrl.dispose();
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
              _buildHandle(),
              CustombuildHeader(
                colorScheme,
                LangKeys.calculations.tr(),
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
            const SizedBox(height: 12),
            _buildField(priceCtrl, LangKeys.timePrice.tr(), Icons.price_change),
            const SizedBox(height: 12),
            _buildField(visaCtrl, LangKeys.visa.tr(), Icons.credit_card),
            const SizedBox(height: 12),
            _buildField(cashCtrl, LangKeys.cash.tr(), Icons.attach_money),
            const SizedBox(height: 12),
            _buildField(
              instapayCtrl,
              LangKeys.instapay.tr(),
              Icons.account_balance_wallet,
            ),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity),
            CustomButton(
              text: LangKeys.save.tr(),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final param = UpdateCalculationsParam(
                    timePrice: int.tryParse(priceCtrl.text) ?? 0,
                    visa: int.tryParse(visaCtrl.text) ?? 0,
                    cash: int.tryParse(cashCtrl.text) ?? 0,
                    instapay: int.tryParse(instapayCtrl.text) ?? 0,
                  );
                  Navigator.pop(context, param);
                }
              },
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
      validator: _validate,
      keyboardType: TextInputType.phone,
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
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty)
      return LangKeys.nameRequired.tr();
  }
}

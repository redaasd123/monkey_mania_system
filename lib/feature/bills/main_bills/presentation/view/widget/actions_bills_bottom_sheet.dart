import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/widget/widget/custom_text_field.dart';
import '../../../../../../core/widget/widget/custom_flush.dart';

class AppBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ColorScheme colorScheme;

  const AppBottomSheet({
    super.key,
    required this.title,
    required this.children,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.15),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.4)
                              : Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 14),
                    Divider(
                      color: colorScheme.primary.withOpacity(0.3),
                      thickness: 1,
                      indent: 40,
                      endIndent: 40,
                    ),
                    const SizedBox(height: 14),

                    // Content
                    ...children,

                    const SizedBox(height: 20),

                    // Accent line
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colorScheme.primary.withOpacity(0.6),
                              colorScheme.secondary.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentBottomSheet extends StatefulWidget {
  final double totalPrice;
  final ColorScheme colorScheme;
  final void Function(double visa, double cash, double instapay) onSave;

  const PaymentBottomSheet({
    super.key,
    required this.totalPrice,
    required this.colorScheme,
    required this.onSave,
  });

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final visaCtrl = TextEditingController();
  final cashCtrl = TextEditingController();
  final instCtrl = TextEditingController();

  double get currentSum =>
      (double.tryParse(visaCtrl.text) ?? 0) +
          (double.tryParse(cashCtrl.text) ?? 0) +
          (double.tryParse(instCtrl.text) ?? 0);

  @override
  void dispose() {
    visaCtrl.dispose();
    cashCtrl.dispose();
    instCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: LangKeys.payment.tr(),
      colorScheme: widget.colorScheme,
      children: [
        _buildTotalPrice(),
        const SizedBox(height: 16),

        // Fields
        CustomTextField(
          label: LangKeys.visa.tr(),
          hint: LangKeys.enterValue.tr(),
          controller: visaCtrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          label: LangKeys.cash.tr(),
          hint: LangKeys.enterValue.tr(),
          controller: cashCtrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          label: LangKeys.instapay.tr(),
          hint: LangKeys.enterValue.tr(),
          controller: instCtrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),

        const SizedBox(height: 16),

        _buildSummary(),
        const SizedBox(height: 20),

        _buildSaveButton(context),
      ],
    );
  }

  Widget _buildTotalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LangKeys.totalPrice.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: widget.colorScheme.secondary,
          ),
        ),
        Text(
          '${widget.totalPrice.toStringAsFixed(2)} ج.م',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: widget.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    final correct = (widget.totalPrice - currentSum).abs() < 0.01;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LangKeys.totalPrice.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '${currentSum.toStringAsFixed(2)} ج.م',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: correct ? Colors.green : Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.colorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
      ),
      icon: const Icon(Icons.save, color: Colors.white),
      label: Text(
        LangKeys.save.tr(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        if ((widget.totalPrice - currentSum).abs() < 0.01) {
          widget.onSave(
            double.tryParse(visaCtrl.text) ?? 0,
            double.tryParse(cashCtrl.text) ?? 0,
            double.tryParse(instCtrl.text) ?? 0,
          );
          Navigator.pop(context);
        } else {
          showRedFlush(context, LangKeys.sumNotEqual.tr());
        }
      },
    );
  }
}

class DiscountBottomSheet extends StatelessWidget {
  final ColorScheme colorScheme;
  final void Function(String discount) onSave;

  const DiscountBottomSheet({
    super.key,
    required this.colorScheme,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController();

    return AppBottomSheet(
      title: LangKeys.discountType.tr(),
      colorScheme: colorScheme,
      children: [
        CustomTextField(
          keyboardType: TextInputType.name,
          label: LangKeys.discountType.tr(),
          hint: LangKeys.discountType.tr(),
          controller: ctrl,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
          ),
          icon: const Icon(Icons.percent, color: Colors.white),
          label: Text(
            LangKeys.save.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            onSave(ctrl.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

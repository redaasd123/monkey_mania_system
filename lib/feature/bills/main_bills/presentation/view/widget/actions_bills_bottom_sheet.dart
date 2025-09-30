

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/widget/widget/custom_text_field.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/update_calculations_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/show_calculations_bottom_sheet.dart';

import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/widget/widget/custom_flush.dart';
import '../../../domain/entity/Bills_entity.dart';
import '../../../domain/use_case/param/close_bills_param.dart';
import '../../../domain/use_case/param/fetch_bills_param.dart';
import '../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../manager/close_bills_cubit/close_bills_cubit.dart';
import 'apply_discount_param.dart';
import 'bills_view_body_item.dart';
class AppBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ColorScheme colorScheme;
  final List<Color> gradientColors;

  const AppBottomSheet({
    super.key,
    required this.title,
    required this.children,
    required this.colorScheme,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
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
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // تأثير بلور شفاف
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Handle (المقبض العلوي)
                    Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
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
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimaryContainer,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    const SizedBox(height: 14),

                    // Content
                    ...children,

                    const SizedBox(height: 12),

                    // Action indicator (زي شادو بسيط تحت)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 100),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
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
      gradientColors: [
        widget.colorScheme.primary,
        widget.colorScheme.secondaryContainer,
      ],
      children: [
        // Total Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LangKeys.totalPrice.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.tealAccent,
              ),
            ),
            Text(
              '${widget.totalPrice.toStringAsFixed(2)} ج.م',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.tealAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Fields
        CustomTextField(
          label: LangKeys.visa.tr(),
          hint: LangKeys.enterValue.tr(),
          controller: visaCtrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}), // 👈 ده اللي يخلي currentSum يتحدث
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: LangKeys.cash.tr(),
          hint: LangKeys.enterValue.tr(),
          controller: cashCtrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: LangKeys.instapay.tr(),
          hint: LangKeys.enterValue.tr(),
          controller: instCtrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),

        const SizedBox(height: 16),

        // Current Sum
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "المجموع الحالي",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${currentSum.toStringAsFixed(2)} ج.م',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: currentSum == widget.totalPrice
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Save button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
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
              showRedFlush(context, 'The sum must equal total price');
            }
          },
          child: Text(
            LangKeys.save.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
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
      gradientColors: [Colors.deepPurple.shade300, Colors.deepPurple.shade50],
      children: [
        CustomTextField(
          label: LangKeys.discountType.tr(),
          hint: LangKeys.discountType.tr(),
          controller: ctrl,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
          ),
          onPressed: () {
            onSave(ctrl.text);
            Navigator.pop(context);
          },
          child: Text(
            LangKeys.save.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';

import '../../../../../../core/utils/constans.dart';
import '../../../../../../core/widget/widget/custom_build_header_sheet_.dart';
import '../../../../../../core/widget/widget/custom_text_field.dart';

class GeneralExpenseBottomSheet extends StatefulWidget {
  const GeneralExpenseBottomSheet({super.key, required this.title,this.item});

  final String title;
  final GeneralExpenseItemEntity? item;

  @override
  State<GeneralExpenseBottomSheet> createState() =>
      _GeneralExpenseBottomSheetState();
}

class _GeneralExpenseBottomSheetState extends State<GeneralExpenseBottomSheet> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(widget.item!=null){
      nameCtrl.text=widget.item!.name;
      priceCtrl.text  = widget.item!.totalPrice;
      quantityCtrl.text = widget.item?.quantity.toString() ?? '';
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHandle(),
                CustombuildHeader(colorScheme, widget.title, colorScheme.onPrimary),
                const SizedBox(height: 20),
                _buildForm(context),
              ],
            ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: LangKeys.name.tr(),
              hint: LangKeys.name.tr(),
              controller: nameCtrl,
              keyboardType: TextInputType.text,
            ),
            CustomTextField(
              label: LangKeys.totalPrice.tr(),
              hint: LangKeys.totalPrice.tr(),
              controller: priceCtrl,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: LangKeys.quantity.tr(),
              hint: LangKeys.quantity.tr(),
              controller: quantityCtrl,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomButton(text: LangKeys.save.tr(), onPressed: (){
              final branch = AuthHelper.getBranch();
              if (!_formKey.currentState!.validate()) {
                return;
              }
              final param = CreateExpenseParam(
                name: nameCtrl.text,
                branchId: branch,
                totalPrice: priceCtrl.text,
                quantity: quantityCtrl.text,
              );
              Navigator.pop(context,param);
            },)
          ],
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
}







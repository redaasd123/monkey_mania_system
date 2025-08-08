import 'package:flutter/cupertino.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/phone_field.dart';

class NewChildField {
  final TextEditingController nameController;
  final TextEditingController birthDateController;
  final List<PhoneField> phoneFields;

  NewChildField()
      : nameController = TextEditingController(),
        birthDateController = TextEditingController(),
        phoneFields = [PhoneField()];
}

import 'package:flutter/cupertino.dart';

class PhoneField {
  final TextEditingController controller;
  String relationship;

  PhoneField({String? initialRelation})
    : controller = TextEditingController(),
      relationship = initialRelation ?? '';
}

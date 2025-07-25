import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/styles.dart';

 showSnackBar(BuildContext context, String message) {
 final colorScheme = Theme.of(context).colorScheme; // جلب colorScheme من الثيم

 ScaffoldMessenger.of(context).showSnackBar(

  SnackBar(
   content: Center(
    child: Text(
     message,
     style: Styles.textStyle16.copyWith(color: colorScheme.onSurface), // تعديل لون النص بناءً على الثيم
    ),
   ),
   backgroundColor: colorScheme.primary, // تعديل لون الخلفية بناءً على الثيم
   duration: const Duration(seconds: 6),
  ),
 );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
// lib/core/widget/app_loader.dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 🌟 استدعِ showLoader(context) قبل أى عملية طويلة
void showLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,           // يمنع الإغلاق بالضغط خارجًا
    builder: (_) => const _LoaderDialog(),
  );
}

/// 🌟 استدعِ hideLoader(context) بعد انتهاء العملية
void hideLoader(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

/// 🔄 ويدجت اللودر
class _LoaderDialog extends StatelessWidget {

  const _LoaderDialog();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.65),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(.4),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const SpinKitWave(
            //بـ SpinKitFadingCube
            //استبدل SpinKitCircle
            color: Color(0xFF4D65FF),
            size: 70,
            duration: Duration(milliseconds: 2200),
          ),
        ),
      ),
    );
  }
}

// lib/core/widget/app_loader.dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool _isLoaderShowing = false;

void showLoader(BuildContext context) {
  if (_isLoaderShowing) return;
  _isLoaderShowing = true;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const _LoaderDialog(),
  );
}

void hideLoader(BuildContext context) {
  if (_isLoaderShowing && Navigator.of(context, rootNavigator: true).canPop()) {
    _isLoaderShowing = false;
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
            color: Colors.brown,
            size: 70,
            duration: Duration(milliseconds: 2200),
          ),
        ),
      ),
    );
  }
}

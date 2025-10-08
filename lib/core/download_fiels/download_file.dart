import 'dart:io';

import 'package:dio/dio.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
class FileDownloaderUI {
  Future<void> downloadFile(BuildContext context, String url, String fileName)
  async {
    Directory downloadsDir;

    if (Platform.isAndroid) {
      downloadsDir = Directory("/storage/emulated/0/Download");
    } else {
      downloadsDir = await getApplicationDocumentsDirectory();
    }
    String savePath = "${downloadsDir.path}/$fileName";
    double progress = 0;
    StateSetter? dialogSetState;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            dialogSetState = setState;
            return AlertDialog(
              title: const Text("جاري التحميل"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 16),
                  Text("${(progress * 100).toStringAsFixed(0)}%"),
                ],
              ),
            );
          },
        );
      },
    );

    // نزل الملف
    await getIt.get<Dio>().download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          progress = received / total;
          if (dialogSetState != null) {
            dialogSetState!(() {});
          }
        }
      },
    );

    Navigator.pop(context); // اقفل الـ Dialog

    // رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ الملف اتحفظ في: $savePath")),
    );
  }
}

Future<bool> requestStoragePermission() async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    return true;
  } else {
    return false;
  }
}

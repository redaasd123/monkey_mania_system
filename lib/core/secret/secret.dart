import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/widget/logo_with_shimer.dart';

String kBaseUrl = 'https://monkey-mania-production.up.railway.app/';

class SecretTapArea extends StatefulWidget {
  const SecretTapArea({super.key});

  @override
  State<SecretTapArea> createState() => _SecretTapAreaState();
}

class _SecretTapAreaState extends State<SecretTapArea> {
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onTap() {
    _tapCount++;
    if (_tapCount >= 5) {
      _tapCount = 0;
      _showDeveloperDialog();
    }
  }

  void _showDeveloperDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Developer Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Base URL:\n$kBaseUrl'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  if (kBaseUrl == 'https://new.monkey-mania.com/') {
                    kBaseUrl =
                        'https://monkey-mania-production.up.railway.app/';
                  } else {
                    kBaseUrl = 'https://new.monkey-mania.com/';
                  }
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Base URL changed to $kBaseUrl')),
                );
              },
              child: const Text('Switch Base URL'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isStaging =
        kBaseUrl == 'https://monkey-mania-production.up.railway.app/';
    return Container(
      child: Center(
        child: GestureDetector(onTap: _onTap, child: LogoWithAnimatedText()),
      ),
    );
  }
}

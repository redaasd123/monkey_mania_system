import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadSavedBaseUrl();
  }

  Future<void> _loadSavedBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrl = prefs.getString('base_url');
    if (savedUrl != null) {
      setState(() {
        kBaseUrl = savedUrl;
      });
    }
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
                final prefs = await SharedPreferences.getInstance();
                setState(() {
                  if (kBaseUrl ==
                      'https://monkey-mania-production.up.railway.app/') {
                    kBaseUrl = 'https://new.monkey-mania.com/';
                  } else {
                    kBaseUrl =
                    'https://monkey-mania-production.up.railway.app/';
                  }
                });

                await prefs.setString('base_url', kBaseUrl);

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

    final isStaging = kBaseUrl=='https://monkey-mania-production.up.railway.app/';
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.primary.withOpacity(0.05),
      child: Center(
        child: GestureDetector(
          onTap: _onTap,
          child: Text(
            "Smart Management".tr(),
            style: GoogleFonts.roboto(
              color: isStaging?Colors.red:Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

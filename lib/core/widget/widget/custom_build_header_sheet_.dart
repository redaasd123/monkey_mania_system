import 'package:flutter/material.dart';

import '../../utils/constans.dart';

Widget CustombuildHeader(ColorScheme colorScheme, String title, Color color) {
  return Row(
    children: [
      const CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(kTest),
      ),
      const SizedBox(width: 12),
      Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ],
  );
}

Widget buildHandle() => Center(
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





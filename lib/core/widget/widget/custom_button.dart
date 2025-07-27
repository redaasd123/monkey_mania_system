import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = LinearGradient(
      colors: isDark
          ? [Colors.purple, Colors.brown]
          : [Colors.brown, Colors.brown],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // ثابتة هنا لأن الجريدينت غامق
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    this.onChanged,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    required this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged:widget.onChanged ,
        validator: _validator,
        style: TextStyle(color: scheme.onBackground),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscure : false,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: scheme.primary,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : null,
          labelText: widget.label,
          hintText: widget.hint,
          labelStyle: TextStyle(

            color:Colors.teal,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          hintStyle: TextStyle(color: scheme.onBackground.withOpacity(0.6)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: scheme.primary),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: scheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  String? _validator(String? data) {
    final value = data?.trim() ?? '';

    if (value.isEmpty) return 'من فضلك أدخل هذا الحقل';

    if (widget.keyboardType == TextInputType.phone) {
      // if (!RegExp(r'^01[0125]\d{8}\$').hasMatch(value)) {
      //   return 'رقم هاتف غير صحيح';
      // }
    }

    if (widget.isPassword) {
      if (value.length < 6) {
        return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
      }
    }

    return null;
  }
}

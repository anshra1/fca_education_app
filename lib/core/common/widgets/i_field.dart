import 'package:flutter/material.dart';

class IField extends StatelessWidget {
  const IField({
    required this.controller,
    super.key,
    this.validator,
    this.filled = false,
    this.fillColor,
    this.obsecureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.overrideValidator = false,
    this.style,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColor;
  final bool obsecureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? style;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This Field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      obscureText: obsecureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 50),
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: style ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}

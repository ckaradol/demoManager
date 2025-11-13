import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final bool? obsecureText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final Function(String value)? onChange;
  final TextEditingController? controller;
  final String labelText;

  const AppTextFormField({super.key, required this.labelText, required this.controller, this.suffixIcon, this.obsecureText, this.textInputType, this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obsecureText ?? false,
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(suffixIcon: suffixIcon, label: Text(labelText), border: OutlineInputBorder()),
    );
  }
}

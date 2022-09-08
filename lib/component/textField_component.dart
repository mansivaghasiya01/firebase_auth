// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  Icon? icon;
  TextInputType? textInputType;
  bool enable;
  String? Function(String?) validator;
  bool obscureText;
  Widget? suffixIcon;

  TextFieldComponent(
      {Key? key,
      required this.controller,
      required this.label,
      required this.icon,
      this.textInputType,
      this.enable = true,
      required this.validator,
      this.suffixIcon,
      this.obscureText = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          prefixIcon: icon,
          enabled: enable,
          labelText: label,
          suffixIcon: suffixIcon),
      validator: validator,
      obscureText: obscureText,
    );
  }
}

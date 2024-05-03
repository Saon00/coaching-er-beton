import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final FormFieldValidator? fieldValidator;
  const TextFormWidget({
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.fieldValidator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: fieldValidator,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        hintText: hintText,
        hintStyle: titlePopins,
        fillColor: greyColor,
        focusColor: greyColor,
      ),
      cursorColor: greyColor,
    );
  }
}

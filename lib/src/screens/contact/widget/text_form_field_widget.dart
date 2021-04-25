import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplest/simplest.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextCapitalization textCaptilization;
  final int maxLine;

  TextFormFieldWidget(
      {this.icon,
      this.controller,
      this.hintText,
      this.validator,
      this.textCaptilization = TextCapitalization.none,
      this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCaptilization,
      maxLines: maxLine,
      controller: controller,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      validator: validator,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          hintText: hintText.tr,
          hintStyle: TextStyle(color: Color(0xFFB3B4B4), fontSize: 14),
          prefixIcon:
              icon == null ? null : Icon(icon, color: appIconColor, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: appIconColor, width: 1.6),
          )),
    );
  }
}

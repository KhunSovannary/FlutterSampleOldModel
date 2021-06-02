import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {@required this.hintText,
      @required this.controller,
      @required this.readOnly,
      @required this.hintTextStyle,
      @required this.onTap});

  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final TextStyle hintTextStyle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      decoration: new InputDecoration(
          isDense: true,
          focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey.shade600)),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey.shade300)),
          hintText: hintText ?? '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          hintStyle: hintTextStyle == null
              ? TextStyle(fontSize: 14, color: Colors.black87)
              : hintTextStyle),
    );
  }
}

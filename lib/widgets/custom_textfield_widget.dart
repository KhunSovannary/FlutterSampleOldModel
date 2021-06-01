import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {

  CustomTextFieldWidget({
    @required this.title,
    @required this.iconData,
    @required this.obscureText,
    @required this.numberOnly,
    @required this.onChanged,
    @required this.textEditingController,
    @required this.inputDecoration
  });

  final String title;
  final IconData iconData;
  final bool obscureText;
  final bool numberOnly;
  final Function onChanged;
  final TextEditingController textEditingController;
  final InputDecoration inputDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        controller: textEditingController,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: inputDecoration != null ? inputDecoration : InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey.shade500)),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.green)),
          prefixIcon: Icon(iconData, color: Colors.grey, size: 22,),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: title,
        ),
        keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
        inputFormatters: numberOnly ?  <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ] : [],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ActionOptionWidget extends StatelessWidget {

  ActionOptionWidget({@required this.title, @required this.textStyle, @required this.function});

  final String title;
  final TextStyle textStyle;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5),
          ),
          color: Colors.white,
        ),
        child: Center(child: Text(title, style: textStyle,)),
      ),
    );
  }
}

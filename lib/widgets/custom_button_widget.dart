import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';

class CustomButtonWidget extends StatelessWidget {

  CustomButtonWidget({@required this.title, @required this.function});

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppTheme.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20,),
            textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        onPressed: function,
        child: Text(title, style: TextStyle(
            color: Colors.white, fontSize: 16
        ),),
      ),
    );
  }
}

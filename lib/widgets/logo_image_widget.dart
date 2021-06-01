import 'package:flutter/material.dart';

class LogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * 0.2,
        width: MediaQuery.of(context).size.width * 0.2,
        child: Image.asset('images/logo.png')
    );
  }
}

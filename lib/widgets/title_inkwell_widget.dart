import 'package:flutter/material.dart';

class TitleInkWellWidget extends StatelessWidget {

  TitleInkWellWidget({
    @required this.iconData,
    @required this.image,
    @required this.title,
    @required this.size,
  });

  final IconData iconData;
  final String image;
  final String title;
  final double size;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            image != null ? SizedBox(
              height: MediaQuery.of(context).size.width * 0.07,
              width: MediaQuery.of(context).size.width * 0.07,
              child: Image.asset(image),
            ) : Icon(iconData, size: size,),
            SizedBox(width: 10),
            Text(title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
            ),
          ],
        ),
      ],
    );
  }
}

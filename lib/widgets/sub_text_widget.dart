import 'package:flutter/material.dart';

class SubTextWidget extends StatelessWidget {

  SubTextWidget({
    @required this.title,
    @required this.price,
    @required this.text,
    @required this.textStyleTitle,
    @required this.textStylePrice,
  });

  final String title;
  final double price;
  final String text;
  final TextStyle textStyleTitle;
  final TextStyle textStylePrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(title, style: textStyleTitle != null ? textStyleTitle : TextStyle(
              fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500
            ),),
          ),
          Flexible(
            flex: 4,
              child: price != null ? Text('\$ ${price.toStringAsFixed(2)}', style: textStyleTitle != null ? textStylePrice : TextStyle(
                  fontWeight: FontWeight.bold
              ),
              ) : Text(text,
                style: textStylePrice != null ? textStylePrice : TextStyle(
                    fontWeight: FontWeight.bold
                ),)
          )
        ],
      ),
    );
  }
}

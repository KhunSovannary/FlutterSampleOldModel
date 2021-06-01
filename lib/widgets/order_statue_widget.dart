import 'package:flutter/material.dart';
class OrderStatusWidget extends StatelessWidget {

  OrderStatusWidget({@required this.title, @required this.function});

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 15, color: Colors.black87
            ),),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54,)
          ],
        ),
      ),
    );
  }
}

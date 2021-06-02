import 'package:flutter/material.dart';

class LostInternetConnection extends StatelessWidget {
  const LostInternetConnection({@required this.message, Key key})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 70,
            color: Colors.grey.shade400,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            message,
            style: TextStyle(
                color: Colors.grey.shade400, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {

  ViewImageScreen({@required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.clear, size: 24, color: Colors.grey,),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Center(
          child: FadeInImage(
            image: NetworkImage(image),
            placeholder: AssetImage(
                "images/placeholder.png"),
            imageErrorBuilder:
                (context, error, stackTrace) {
              return Image.asset(
                  'images/placeholder.png',
                  fit: BoxFit.fitWidth);
            },
            fit: BoxFit.fitWidth,
          )
      ),
    );
  }
}

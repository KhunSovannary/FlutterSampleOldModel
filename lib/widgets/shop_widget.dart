import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';
import 'package:flutter_chabhuoy/models/shop_model.dart';

class ShopWidget extends StatelessWidget {
  ShopWidget({@required this.shop, @required this.padding});

  final ShopModel shop;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(padding ?? 15),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage(shop.logoImage ?? 'none'),
                  placeholder: AssetImage("images/placeholder.png"),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('images/placeholder.png',
                        fit: BoxFit.fitWidth);
                  },
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppTheme.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Go to store'.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

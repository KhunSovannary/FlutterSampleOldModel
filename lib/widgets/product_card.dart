import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';

class ProductCard extends StatelessWidget {
  ProductCard({@required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: FadeInImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                product.imageName ?? 'none',
              ),
              placeholder: AssetImage("images/placeholder.png"),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('images/placeholder.png',
                    fit: BoxFit.fitWidth);
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                      Expanded(
                        child: Text(
                          '\$${product.unitPrice} / ${product.unitName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

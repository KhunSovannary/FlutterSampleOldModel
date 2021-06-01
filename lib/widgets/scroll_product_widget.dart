import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/screens/product_detail_screen.dart';

class ScrollProductWidget extends StatelessWidget {
  ScrollProductWidget({@required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: products
              .map((product) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product)),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 3,
                                child: FadeInImage(
                                  image:
                                      NetworkImage(product.imageName ?? 'none'),
                                  placeholder:
                                      AssetImage("images/placeholder.png"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset('images/placeholder.png',
                                        fit: BoxFit.fitWidth);
                                  },
//                          fit: BoxFit.fitWidth,
                                )),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '\$${product.unitPrice} / ${product.unitName}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

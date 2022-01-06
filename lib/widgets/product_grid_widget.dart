import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/screens/product_detail_screen.dart';

class ProductGridWidget extends StatelessWidget {
  ProductGridWidget({@required this.products, @required this.scrollController});

  final List<ProductModel> products;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final double itemHeight = MediaQuery.of(context).size.width * 0.65;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        primary: false,
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        children: products
            .map<Widget>((product) => InkWell(
                  splashColor: Colors.green.shade200,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product)),
                    );
                  },
                  child: Card(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
//                                      '\$${product.unitPrice}',
                                      '\$${product.unitPrice} / ${product.unitName}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.red,
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
                  )),
                ))
            .toList());
  }
}

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
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
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
//                                  SizedBox(height: 5,),
                                    Text(
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
//    return CustomScrollView(
//      scrollDirection: Axis.vertical,
//      shrinkWrap: true,
//      primary: false,
//      reverse: true,
//      controller: scrollController,
//      slivers: <Widget>[
//        SliverPadding(
//          padding: const EdgeInsets.all(8),
//          sliver: SliverGrid.count(
//              crossAxisCount: 2,
//              childAspectRatio: (itemWidth / itemHeight),
//              crossAxisSpacing: 10,
//              mainAxisSpacing: 10,
//              children: products.map((product) => InkWell(
//                splashColor: Colors.green.shade200,
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
//                  );
//                },
//                child: Card(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.stretch,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        Flexible(
//                          flex: 5,
//                            child: FadeInImage(
//                              fit: BoxFit.fitWidth,
//                              image: NetworkImage(product.imageName ?? 'none',),
//                              placeholder: AssetImage(
//                                  "images/placeholder.png"),
//                              imageErrorBuilder:
//                                  (context, error, stackTrace) {
//                                return Image.asset(
//                                    'images/placeholder.png',
//                                    fit: BoxFit.fitWidth);
//                              },
//                            ),
//                        ),
//                        Flexible(
//                          flex: 2,
//                          child: Container(
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Container(
//                                child: Column(
//                                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Text(product.name,
//                                      overflow: TextOverflow.ellipsis,
//                                      style: TextStyle(
//                                        fontSize: 15
//                                      ),
//                                    ),
////                                  SizedBox(height: 5,),
//                                    Text(
//                                      '\$${product.unitPrice} / ${product.unitName}',
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle(
//                                        fontWeight: FontWeight.w600,
//                                        fontSize: 16,
//                                        color: Colors.red,
//                                      ),
//                                    ),
//
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    )
//                ),
//              )).toList()
//          ),
//        ),
//      ],
//    );
  }
}

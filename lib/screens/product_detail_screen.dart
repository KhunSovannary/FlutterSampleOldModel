import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/product_detail_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:flutter_chabhuoy/widgets/add_to_cart_widget.dart';
import 'package:flutter_chabhuoy/widgets/lost_internet_connection.dart';
import 'package:flutter_chabhuoy/widgets/product_card.dart';
import 'package:flutter_chabhuoy/widgets/product_grid_widget.dart';
import 'package:flutter_chabhuoy/widgets/product_image_detail.dart';
import 'package:flutter_chabhuoy/widgets/product_option_widget.dart';
import 'package:flutter_chabhuoy/widgets/shop_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({@required this.product});

  final ProductModel product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CarouselController _controller = CarouselController();

  Map<int, Value> optionSelected = {};
  Map<int, Option> productOptions = {};
  String image;
  int countCart = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartRepository = Provider.of<CartRepository>(context);
    final productRepository =
        Provider.of<ProductRepository>(context, listen: false);
    final double padding = 10;

    final double itemHeight = MediaQuery.of(context).size.width * 0.65;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: Colors.orange, //change your color here
        ),
        title: Text('Product Detail', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<ProductDetailModel>(
        future:
            productRepository.getProductDetail(productId: widget.product.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageDetail(
                          images: snapshot.data.product.images,
                          controller: _controller),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              snapshot.data.product.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '\$ ${snapshot.data.product.unitPrice}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                    snapshot.data.product.options.length,
                                    (indexOption) => Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                snapshot.data.product
                                                    .options[indexOption].name
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Wrap(
                                                children: List.generate(
                                                    snapshot
                                                        .data
                                                        .product
                                                        .options[indexOption]
                                                        .values
                                                        .length,
                                                    (index) => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10,
                                                                  top: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: optionSelected
                                                                        .containsKey(
                                                                            indexOption)
                                                                    ? optionSelected[indexOption].id ==
                                                                            snapshot
                                                                                .data
                                                                                .product
                                                                                .options[
                                                                                    indexOption]
                                                                                .values[
                                                                                    index]
                                                                                .id
                                                                        ? AppTheme
                                                                            .primaryColor
                                                                        : Colors
                                                                            .grey
                                                                            .shade300
                                                                    : Colors
                                                                        .grey
                                                                        .shade300,
                                                                width: 1),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .white,
                                                                  spreadRadius:
                                                                      1),
                                                            ],
                                                          ),
                                                          child:
                                                              ProductOptionWidget(
                                                                  optionsValue: snapshot
                                                                      .data
                                                                      .product
                                                                      .options[
                                                                          indexOption]
                                                                      .values[index],
                                                                  function: () {
                                                                    if (optionSelected
                                                                        .containsKey(
                                                                            indexOption)) {
                                                                      // update to option
                                                                      setState(
                                                                          () {
                                                                        productOptions.update(
                                                                            indexOption,
                                                                            (value) =>
                                                                                new Option(id: snapshot.data.product.options[indexOption].id, name: snapshot.data.product.options[indexOption].name, values: [
                                                                                  snapshot.data.product.options[indexOption].values[index]
                                                                                ]));

                                                                        // update selected color
                                                                        optionSelected.update(
                                                                            indexOption,
                                                                            (value) =>
                                                                                snapshot.data.product.options[indexOption].values[index]);
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        // update to option
                                                                        productOptions.putIfAbsent(
                                                                            indexOption,
                                                                            () =>
                                                                                new Option(id: snapshot.data.product.options[indexOption].id, name: snapshot.data.product.options[indexOption].name, values: [
                                                                                  snapshot.data.product.options[indexOption].values[index]
                                                                                ]));

                                                                        // add selected color
                                                                        optionSelected.putIfAbsent(
                                                                            indexOption,
                                                                            () =>
                                                                                snapshot.data.product.options[indexOption].values[index]);
                                                                      });
                                                                    }

                                                                    if (snapshot
                                                                            .data
                                                                            .product
                                                                            .options[indexOption]
                                                                            .values[index]
                                                                            .imageName !=
                                                                        null) {
                                                                      int allImage = snapshot
                                                                          .data
                                                                          .product
                                                                          .images
                                                                          .length;
                                                                      int optionImage = snapshot
                                                                          .data
                                                                          .product
                                                                          .options[
                                                                              indexOption]
                                                                          .values
                                                                          .length;
                                                                      _controller.animateToPage(allImage -
                                                                          optionImage +
                                                                          index);
                                                                      // set image
                                                                      setState(
                                                                          () {
                                                                        image = snapshot
                                                                            .data
                                                                            .product
                                                                            .options[indexOption]
                                                                            .values[index]
                                                                            .imageName;
                                                                      });
                                                                    }
                                                                  }),
                                                        )),
                                              )
                                            ],
                                          ),
                                        ))),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(snapshot.data.product.description),
                          ],
                        ),
                      ),
                      ShopWidget(shop: snapshot.data.shop, padding: padding),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(padding),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'More Fore You',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            GridView.count(
                                childAspectRatio: (itemWidth / itemHeight),
                                primary: false,
//                              controller: controller,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                children: snapshot.data.relatedProduct
                                    .map<Widget>((product) => InkWell(
                                          splashColor: Colors.green.shade200,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailScreen(
                                                          product: product)),
                                            );
                                          },
                                          child: ProductCard(product: product),
                                        ))
                                    .toList())
//                          ProductGridWidget(products: snapshot.data.relatedProduct)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: AddToCardWidget(
                  count: countCart,
                  onPressIncreasing: () {
                    setState(() => {++countCart});
                  },
                  onPressDecreasing: () {
                    setState(() => {
                          --countCart,
                          if (countCart <= 0) {countCart = 0}
                        });
                  },
                  onPressAdd: () {
                    if (countCart > 0) {
                      if (snapshot.data.product.options.length == 0) {
                        cartRepository.addItem(
                            snapshot.data.product,
                            image ?? snapshot.data.product.imageName,
                            countCart, []);
                        Navigator.pop(context);
                      } else if (snapshot.data.product.options.length ==
                          productOptions.length) {
                        cartRepository.addItem(
                            snapshot.data.product,
                            image ?? snapshot.data.product.imageName,
                            countCart,
                            productOptions.values.toList());
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(App.snackBarUnselectProductOption);
                      }
                    }
                  },
                ));
          }

          if (snapshot.hasError) {
            return LostInternetConnection(message: snapshot.error);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

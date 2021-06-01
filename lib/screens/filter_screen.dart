import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/repository/filter_repository.dart';
import 'package:flutter_chabhuoy/screens/product_detail_screen.dart';
import 'package:flutter_chabhuoy/widgets/product_card.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({@required this.query});

  final String query;

  final FilterRepository filterRepository = FilterRepository();

  @override
  Widget build(BuildContext context) {
    final double itemHeight = MediaQuery.of(context).size.width * 0.65;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: App.iconsThem,
      ),
      body: FutureBuilder<List<ProductModel>>(
          future: filterRepository.searchProduct(query: query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  child: GridView.count(
                      childAspectRatio: (itemWidth / itemHeight),
                      primary: false,
                      controller: null,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: snapshot.data
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
                          .toList()));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

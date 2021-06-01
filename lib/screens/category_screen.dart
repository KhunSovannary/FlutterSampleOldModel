import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/category_product_model.dart';
import 'package:flutter_chabhuoy/screens/product_detail_screen.dart';
import 'package:flutter_chabhuoy/services/localization_service.dart';
import 'package:flutter_chabhuoy/widgets/category_widget.dart';
import 'package:flutter_chabhuoy/widgets/product_card.dart';
import 'package:provider/provider.dart';
import '../repository/category_repository.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({@required this.title, @required this.categoryId, Key key})
      : super(key: key);

  final String title;
  final int categoryId;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryRepository categoryRepository = CategoryRepository();


  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: App.iconsThem,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: FutureBuilder<CategoryProductModel>(
        future:
            categoryRepository.fetchCategoryById(categoryId: widget.categoryId, locale: localizationService.locale),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status) {
              return Scaffold(
                appBar: snapshot.data.data.subCategories.length <= 0
                    ? PreferredSize(
                        preferredSize: Size.fromHeight(
                            MediaQuery.of(context).size.width *
                                0), // here the desired height
                        child: Text(''),
                      )
                    : PreferredSize(
                        preferredSize: Size.fromHeight(
                            MediaQuery.of(context).size.width *
                                0.25), // here the desired height
                        child: AppBar(
                          toolbarHeight: MediaQuery.of(context).size.width * 4,
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          titleSpacing: 0,
                          actions: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                child: CategoryWidget(
                                    data: snapshot.data.data.subCategories)),
                          ],
                        ),
                      ),
                body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GridView.count(
                            childAspectRatio: (App.itemWidth(context) /
                                App.itemHeight(context)),
                            primary: false,
                            controller: null,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: snapshot.data.data.products
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
                      ]),
                ),
              );
            }
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

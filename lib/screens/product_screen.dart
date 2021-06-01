import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:flutter_chabhuoy/screens/product_detail_screen.dart';
import 'package:flutter_chabhuoy/screens/search_screen.dart';
import 'package:flutter_chabhuoy/services/localization_service.dart';
import 'package:flutter_chabhuoy/widgets/product_card.dart';
import 'package:flutter_chabhuoy/widgets/product_grid_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final controller = ScrollController();
  int productPage = 1;

  @override
  void initState() {
    super.initState();
    // Setup the listener.
    controller.addListener(listenScrolling);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productPage = 0;
  }

  void listenScrolling() {
    if (controller.position.atEdge) {
      final isTop = controller.position.pixels == 0;

      if (isTop) {
        print('top');
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {
            productPage++;
          });
          Provider.of<ProductRepository>(context, listen: false)
              .getProducts(page: productPage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final products = Provider.of<ProductRepository>(context);
    if (products.getLengthProduct == 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        products.getProducts(locale: localizationService.locale);
      });
    }

    final double itemHeight = MediaQuery.of(context).size.width * 0.65;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.white),
              child: new TextField(
                readOnly: true,
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen())),
                },
                decoration: new InputDecoration(
                  fillColor: Colors.grey.shade200,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black54, width: 0.1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black54, width: 0.1),
                  ),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: -5, horizontal: 20),
                  hintText: AppLocalizations.of(context).search,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: GridView.count(
            childAspectRatio: (itemWidth / itemHeight),
            primary: false,
            controller: controller,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: products.getListProducts
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
                      child: ProductCard(product: product),
                    ))
                .toList()));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/models/query_product_model.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:flutter_chabhuoy/screens/filter_screen.dart';
import 'package:flutter_chabhuoy/widgets/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static String _displayStringForOption(QueryModel option) => option.name;

  String query = '';

  @override
  Widget build(BuildContext context) {
    final productRepository =
        Provider.of<ProductRepository>(context, listen: false);
    if (productRepository.getFilterProduct.length == 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        productRepository.getFilterName();
      });
    } else {
      productRepository.getFilterName();
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.orange.shade100,
                  primaryColorDark: Colors.orange,
                ),
                child: Autocomplete<QueryModel>(
                  displayStringForOption: _displayStringForOption,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    setState(() {
                      query = textEditingValue.text;
                    });

                    if (textEditingValue.text == '') {
                      return const Iterable<QueryModel>.empty();
                    }

                    return productRepository.getFilterProduct
                        .where((QueryModel option) {
                      return option.name
                          .toString()
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (QueryModel option) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterScreen(
                                  query: option.name,
                                )));
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: query.length == 0
                  ? TextButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.orange),
                      ))
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterScreen(
                                      query: query,
                                    )));
                      }),
            )
          ],
        ),
      )),
    );
  }
}

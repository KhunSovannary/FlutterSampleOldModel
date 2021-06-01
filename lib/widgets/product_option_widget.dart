import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:provider/provider.dart';

class ProductOptionWidget extends StatelessWidget {
  ProductOptionWidget({@required this.optionsValue, @required this.function});

  final optionsValue;
  final Function function;

  @override
  Widget build(BuildContext context) {
    final productRepository = Provider.of<ProductRepository>(context);

    return InkWell(
        onTap: function,
        child: optionsValue.imageName == null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(
                  optionsValue.name,
                  style: TextStyle(color: Colors.black87),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Image.network(
                      optionsValue.imageName,
                      fit: BoxFit.fitWidth,
                    )),
              ));
  }
}

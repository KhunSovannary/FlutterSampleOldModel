import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:provider/provider.dart';

class CartListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CartRepository>(context);

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cartItem.items
              .map((item) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.8,
                                    color: Colors.black12,
                                  )),
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image.network(item.image)),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Flexible(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              cartItem.removeItem(
                                                  item.id.toString());
                                            },
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                              size: 28,
                                            ),
                                          ))
                                    ],
                                  ),
                                  Text('\$ ${item.price.toStringAsFixed(2)}'),
                                  Row(
                                      children: List.generate(
                                    item.options.length,
                                    (index) => Wrap(
                                      children: [
                                        Text(
                                            '${item.options[index].name} : ${item.options[index].values[0].name} ${index == item.options.length - 1 ? '' : '/'} ')
                                      ],
                                    ),
                                  )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.orange,
                                                size: 26,
                                              ),
                                              onPressed: () => {
                                                    cartItem.updateQuantity(
                                                        item.id.toString(), -1)
                                                  }),
                                          Text(
                                            item.quantity.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: Colors.orange,
                                                size: 26,
                                              ),
                                              onPressed: () => {
                                                    cartItem.updateQuantity(
                                                        item.id.toString(), 1)
                                                  })
                                        ],
                                      ),
                                      Text(
                                        '\$ ${(item.price * item.quantity).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}

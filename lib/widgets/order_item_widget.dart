import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/order_item_model.dart';

class OrderItemWidget extends StatelessWidget {
  OrderItemWidget({@required this.item});

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Image.network(
                  item.imageName ?? '',
                  errorBuilder: (context, exception, stackTrack) =>
                      Image.asset('images/placeholder.png'),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(item.name),
                  SizedBox(height: 4),
                  Text(
                    '\$ ${item.unitPrice}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '\$ ${(item.quantity * double.parse(item.unitPrice.toString()))}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

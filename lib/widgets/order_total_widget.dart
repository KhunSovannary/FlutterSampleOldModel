import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/widgets/sub_text_widget.dart';

class OrderTotalWidget extends StatelessWidget {
  OrderTotalWidget(
      {@required this.order,
      @required this.discounts,
      @required this.deliveryOption});

  final OrderModel order;
  final Discounts discounts;
  final DeliveryOption deliveryOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SubTextWidget(
                title: 'Sub Total :',
                price: double.parse(order.total.toString()),
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            SubTextWidget(
                title: 'Discount :',
                price: discounts.total == null
                    ? 0.00
                    : double.parse(discounts.total.toString()),
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            SubTextWidget(
                title: 'Delivery Fee :',
                price: deliveryOption.deliveryFee != null
                    ? double.parse(deliveryOption.deliveryFee.toString())
                    : 0.00,
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Divider(),
            SubTextWidget(
                title: 'Total :',
                price: double.parse(order.total.toString()),
                textStyleTitle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textStylePrice: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/widgets/sub_text_widget.dart';

class OrderInformationWidget extends StatelessWidget {
  OrderInformationWidget({@required this.order, @required this.user});

  final User user;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey.shade100,
            child: Text(
              'Order Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SubTextWidget(
              title: 'Status :',
              text: App.status[order.orderStatusId],
              textStyleTitle: null,
              textStylePrice: TextStyle(
                  fontSize: 16,
                  color: App.textStatusColor[order.orderStatusId])),
          SubTextWidget(
              title: 'Order ID :',
              text: '#${order.id}',
              textStyleTitle: null,
              textStylePrice: TextStyle(fontSize: 16)),
          SubTextWidget(
              title: 'Ordered By :',
              text: '${user.fullName} (${order.phonePickup})',
              textStyleTitle: null,
              textStylePrice: TextStyle(fontSize: 14)),
          SubTextWidget(
              title: 'Ordered Date :',
              text: order.deliveryPickupDate,
              textStyleTitle: null,
              textStylePrice: TextStyle(fontSize: 14)),
          SubTextWidget(
              title: 'Note* :',
              text: order.note,
              textStyleTitle: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
              textStylePrice:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/widgets/sub_text_widget.dart';

class OrderDeliveryMethodWidget extends StatelessWidget {

  OrderDeliveryMethodWidget({@required this.user, @required this.order, @required this.deliveryOption});

  final OrderModel order;
  final User user;
  final DeliveryOption deliveryOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delivery Method', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),),
            ),
            SubTextWidget(title: 'Name :',
                text: user.fullName ?? '',
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600
                ),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                )
            ),
            SubTextWidget(title: 'Delivery Fee :',
                text: order.phonePickup ?? '',
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600
                ),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                )
            ),
            SubTextWidget(title: 'Address :',
                text: order.addressStreetAddress ?? '',
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600
                ),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                )
            ),
            SubTextWidget(title: 'Delivery :',
                text: deliveryOption.deliveryName ?? 'None',
                textStyleTitle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600
                ),
                textStylePrice: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                )
            ),
          ],
        ),
      ),
    );
  }
}

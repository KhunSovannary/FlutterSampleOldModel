import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/screens/order_detail_screen.dart';

class OrderListItemWidget extends StatelessWidget {
  OrderListItemWidget({@required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(
                          orderId: orders[index].id,
                          isSeller: false,
                        )),
              );
            },
            child: Card(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: Image.asset('images/ic_item_order.jpeg'),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(orders[index].userName),
                            Text(orders[index].phonePickup),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: App.bgStatusColor[
                                      orders[index].orderStatusId],
                                ),
                                child: Text(
                                    '\#${orders[index].id} : ${App.status[orders[index].orderStatusId]}'))
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$ ${orders[index].total.toStringAsFixed(2).toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800),
                          ),
                          Text(
                            orders[index].deliveryPickupDate,
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            orders[index].note,
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

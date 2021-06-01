import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/shop_order_list_model.dart';
import 'package:flutter_chabhuoy/repository/my_shop_order_repository.dart';
import 'package:flutter_chabhuoy/screens/order_detail_screen.dart';
import 'package:provider/provider.dart';

class OrderListWidget extends StatelessWidget {
  OrderListWidget({@required this.status});

  final dynamic status;

  @override
  Widget build(BuildContext context) {
    final orderList =
        Provider.of<MyShopOrderRepository>(context, listen: false);

    return FutureBuilder<ShopOrderListModel>(
        future: orderList.getShopOrderList(context: context, status: status),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(
                                  orderId: snapshot.data.orders[index].id,
                                  isSeller: true,
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child:
                                      Image.asset('images/ic_item_order.jpeg'),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data.orders[index].userName),
                                    Text(snapshot
                                        .data.orders[index].phonePickup),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: App.bgStatusColor[snapshot.data
                                              .orders[index].orderStatusId],
                                        ),
                                        child: Text(
                                            '\#${snapshot.data.orders[index].id} : ${App.status[snapshot.data.orders[index].orderStatusId]}'))
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
                                    '\$ ${snapshot.data.orders[index].total.toStringAsFixed(2).toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade800),
                                  ),
                                  Text(
                                    snapshot
                                        .data.orders[index].deliveryPickupDate,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    snapshot.data.orders[index].note,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
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

          if (snapshot.hasError) {
            return Center(
              child: Text('No Data'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

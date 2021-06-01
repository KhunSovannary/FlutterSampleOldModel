import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/repository/my_shop_order_repository.dart';
import 'package:flutter_chabhuoy/repository/order_repository.dart';
import 'package:flutter_chabhuoy/widgets/action_bottom_widget.dart';
import 'package:flutter_chabhuoy/widgets/order_delivery_method_widget.dart';
import 'package:flutter_chabhuoy/widgets/order_information_widget.dart';
import 'package:flutter_chabhuoy/widgets/order_item_widget.dart';
import 'package:flutter_chabhuoy/widgets/order_total_widget.dart';
import 'package:flutter_chabhuoy/widgets/payment_method_widget.dart';
import 'package:flutter_chabhuoy/widgets/sub_text_widget.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({@required this.orderId, @required this.isSeller});

  final int orderId;
  final bool isSeller;

  final App myApp = App();
  final MyShopOrderRepository myShopOrderRepository = MyShopOrderRepository();

  @override
  Widget build(BuildContext context) {
    final orderRepository =
        Provider.of<OrderRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: App.iconsThem,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          'Order Detail',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: FutureBuilder<OrderDetailModel>(
        future:
            orderRepository.getOrderDetail(context: context, orderId: orderId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OrderInformationWidget(
                        order: snapshot.data.data.order,
                        user: snapshot.data.data.user),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: snapshot.data.data.orderItem
                          .map<Widget>((item) => OrderItemWidget(item: item))
                          .toList(),
                    ),
                    OrderTotalWidget(
                        order: snapshot.data.data.order,
                        discounts: snapshot.data.data.discounts,
                        deliveryOption: snapshot.data.data.deliveryOption),
                    OrderDeliveryMethodWidget(
                        user: snapshot.data.data.user,
                        order: snapshot.data.data.order,
                        deliveryOption: snapshot.data.data.deliveryOption),
                    SizedBox(
                      height: 8,
                    ),
                    isSeller == true ? PaymentMethodWidget() : Container(),
                    (snapshot.data.data.order.orderStatusId <= 2 &&
                            isSeller == true)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green.shade800,
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            onPressed: () => {
                                  showModalBottomSheet<void>(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ActionBottomWidget(
                                          order: snapshot.data.data.order,
                                        );
                                      })
                                },
                            child: Text('Action'))
                        : Container(),

                    // check if normal user order when order status is delivering
                    (isSeller == false &&
                            snapshot.data.data.order.orderStatusId == 2)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green.shade800,
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            onPressed: () => {
                              myShopOrderRepository
                                  .updateOrderStatus(orderId: orderId, statusId: 3)
                                  .then((response) => {
                                    if (!response.status)
                                    {
                                      myApp.showMessageDialog(
                                        context: context,
                                        message: response.msg,
                                        icon: Icons.warning)
                                    } else {
                                      Navigator.pop(context),
                                      myApp.showMessageDialog(
                                        context: context,
                                        message: response.msg,
                                        icon: Icons.check)
                                    }
                              }).onError((error, stackTrace) async {
                                myApp.showMessageDialog(
                                  context: context,
                                  message: 'Opp somthing error',
                                  icon: Icons.warning);
                                return;
                                })
                            },
                            child: Text('Received'))
                        : Container(),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("No Data"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

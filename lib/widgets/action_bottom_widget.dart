import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/main.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/repository/my_shop_order_repository.dart';
import 'package:flutter_chabhuoy/widgets/action_option_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionBottomWidget extends StatelessWidget {
  ActionBottomWidget({@required this.order});

  final OrderModel order;

  final App myApp = App();
  final MyShopOrderRepository myShopOrderRepository = MyShopOrderRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionOptionWidget(
                      title: 'Please Select an Option',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      function: () async {},
                    ),
                    ActionOptionWidget(
                      title: 'Mark as: Pending',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500),
                      function: () async {
                        myShopOrderRepository
                            .updateOrderStatus(orderId: order.id, statusId: 1)
                            .then((response) => {
                                  if (!response.status)
                                    {
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.warning)
                                    }
                                  else
                                    {
                                      Navigator.pop(context),
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.check)
                                    }
                                })
                            .onError((error, stackTrace) async {
                          myApp.showMessageDialog(
                              context: context,
                              message: 'Opp somthing error',
                              icon: Icons.warning);
                          return;
                        });
                      },
                    ),
                    ActionOptionWidget(
                      title: 'Mark as: Delivery ',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                      function: () async {
                        myShopOrderRepository
                            .updateOrderStatus(orderId: order.id, statusId: 2)
                            .then((response) => {
                                  if (!response.status)
                                    {
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.warning)
                                    }
                                  else
                                    {
                                      Navigator.pop(context),
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.check)
                                    }
                                })
                            .onError((error, stackTrace) async {
                          myApp.showMessageDialog(
                              context: context,
                              message: 'Opp somthing error',
                              icon: Icons.warning);
                        });
                        ;
                      },
                    ),
                    ActionOptionWidget(
                      title: 'Contact Buyer : ${order.phonePickup}',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w500),
                      function: () async {
                        if (await canLaunch('tel:${order.phonePickup}')) {
                          await launch('tel:${order.phonePickup}');
                        } else {
                          myApp.showMessageDialog(
                              context: context,
                              message: 'Opp can not lunch ${order.phonePickup}',
                              icon: Icons.warning);
                        }
                      },
                    ),
                    ActionOptionWidget(
                      title: 'Cancel Order ',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                      function: () async {
                        myShopOrderRepository
                            .updateOrderStatus(orderId: order.id, statusId: 4)
                            .then((response) => {
                                  if (!response.status)
                                    {
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.warning)
                                    }
                                  else
                                    {
                                      Navigator.pop(context),
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.check)
                                    }
                                })
                            .onError((error, stackTrace) async {
                          myApp.showMessageDialog(
                              context: context,
                              message: 'Opp somthing error',
                              icon: Icons.warning);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                      child: Text('Dismiss',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500))),
                ),
              ),
            )
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/screens/order_detail_screen.dart';
import 'package:flutter_chabhuoy/screens/root_screen.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';

class OrderSuccessfullyScreen extends StatelessWidget {
  const OrderSuccessfullyScreen({@required this.orderId, Key key})
      : super(key: key);

  final dynamic orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                margin: const EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.orange.shade400,
                  boxShadow: [
                    BoxShadow(color: Colors.orange.shade100, spreadRadius: 20),
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 80,
                      )
                    ])),
            Column(
              children: [
                Text('Order Successfully',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.orange)),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(
                                isSeller: false, orderId: orderId)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Order Detail',
                        style: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: CustomButtonWidget(
              title: 'Home',
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootScreen()));
              })),
    );
  }
}

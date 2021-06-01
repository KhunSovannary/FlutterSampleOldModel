import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/repository/order_repository.dart';
import 'package:flutter_chabhuoy/widgets/order_list_items_widget.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatelessWidget {
  MyOrderScreen({@required this.orderStatus});

  final dynamic orderStatus;

  @override
  Widget build(BuildContext context) {
    final orderRepository =
        Provider.of<OrderRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: App.iconsThem,
        title: Text('My Order', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future:
            orderRepository.getMyOrders(context: context, status: orderStatus),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OrderListItemWidget(orders: snapshot.data);
          }

          if (snapshot.hasError) {
            return Center(child: Text('No Data'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

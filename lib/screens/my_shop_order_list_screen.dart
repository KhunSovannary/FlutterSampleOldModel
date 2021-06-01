import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/models/shop_order_list_model.dart';
import 'package:flutter_chabhuoy/repository/my_shop_order_repository.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_chabhuoy/widgets/order_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyShpOrderListScreen extends StatefulWidget {
  @override
  _MyShpOrderListScreenState createState() => _MyShpOrderListScreenState();
}

class _MyShpOrderListScreenState extends State<MyShpOrderListScreen> {
  final _kTabPages = <Widget>[
    OrderListWidget(status: 'all'),
    OrderListWidget(status: '1'),
    OrderListWidget(status: '2'),
    OrderListWidget(status: '3'),
    OrderListWidget(status: '4'),
  ];

  @override
  Widget build(BuildContext context) {
    final shopOrderListRepository = Provider.of<MyShopOrderRepository>(context, listen: false);
    return FutureBuilder<ShopOrderListModel>(
        future: shopOrderListRepository.getShopOrderList(context: context, status: 'all'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      indicatorColor: Colors.green.shade800,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Colors.green.shade800),
                      ),
                      labelColor: Colors.black87,
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      tabs: <Tab>[
                        Tab(text: AppLocalizations.of(context).allOrder),
                        Tab(text: AppLocalizations.of(context).pending),
                        Tab(text: AppLocalizations.of(context).delivery),
                        Tab(text: AppLocalizations.of(context).complete),
                        Tab(text: AppLocalizations.of(context).cancelled)
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: _kTabPages,
                ),
              ),
            );
          }
          if (snapshot.hasError) {
              return Center(
                child: Text('No Data'),
              );
          }

          return Center(child: CircularProgressIndicator());
        }
    );
  }
}


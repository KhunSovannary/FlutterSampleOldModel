import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/screens/my_shop_order_list_screen.dart';
import 'package:flutter_chabhuoy/screens/shop_info_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyShopScreen extends StatefulWidget {
  @override
  _MyShopScreenState createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  int _selectedIndex = 0;

  String title = 'My Shop';

  final List<Widget> _children = [
    MyShpOrderListScreen(),
    Center(child: Text('Request List')),
    ShopInfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          setState(() => title = 'My Shop');
          break;
        case 1:
          setState(() => title = 'Request List');
          break;
        case 2:
          setState(() => title = 'My Info');
          break;
      }

      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: App.iconsThem,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: AppLocalizations.of(context).myShop,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Request List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Info',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade800,
        onTap: _onItemTapped,
      ),
    );
  }
}

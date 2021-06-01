import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:flutter_chabhuoy/repository/home_repository.dart';
import 'package:flutter_chabhuoy/repository/load_config_repository.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:flutter_chabhuoy/screens/account_screen.dart';
import 'package:flutter_chabhuoy/screens/cart_screen.dart';
import 'package:flutter_chabhuoy/screens/checkout_screen.dart';
import 'package:flutter_chabhuoy/screens/order_detail_screen.dart';
import 'package:flutter_chabhuoy/screens/product_screen.dart';
import 'package:flutter_chabhuoy/screens/home_screen.dart';
import 'package:flutter_chabhuoy/services/location_service.dart';
import 'package:flutter_chabhuoy/services/notification_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  NotificationService notificationService = NotificationService();
  final Location location = Location();
  final LoadConfigRepository loadConfigRepository = LoadConfigRepository();
  final App myApp = App();

  int _selectedIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    ProductScreen(),
    Text(''),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initRequestPermission();
//    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<NotificationService>(context);
    notificationService.init(context);

    final locationService = Provider.of<LocationService>(context);
    if (locationService.latitude == null || locationService.longitude == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        locationService.getCurrentLocation();
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.13,
            child: Image.asset('images/logo.png', fit: BoxFit.cover)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Consumer<CartRepository>(
              builder: (context, cart, __) => Row(
                children: [
                  new Stack(
                    children: [
                      new IconButton(
                        icon: new Icon(Icons.shopping_cart,
                            color: AppTheme.primaryColor, size: 28),
                        onPressed: () => {
                          if (cart.itemCount > 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartScreen()),
                            )
                          } else {
                            print(cart.itemCount),
                            ScaffoldMessenger.of(context)
                                .showSnackBar(App.snackBarMessage)
                          }

                        },
                      ),
                      Positioned(
                        top: -2,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          alignment: Alignment.center,
                          child: Text(cart.itemCount.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
          )
        ],
      ),
      body: _children.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: AppLocalizations.of(context).product,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: AppLocalizations.of(context).notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: AppLocalizations.of(context).profile,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  initRequestPermission() async {
    await location.requestPermission();
  }

  void checkUpdate() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        loadConfigRepository.appConfig().then((value) => {
        if (Platform.isAndroid) {
          if (packageInfo.version != value.appAndroidVersion) {
            myApp.showUpdate(context: context ,message: value.message, appUrl: 'https://play.google.com/store/apps/details?id=com.gangos')
          }
        } else if (Platform.isIOS) {
          if (packageInfo.version != value.appIOSVersion) {
            myApp.showUpdate(context: context, message: value.message, appUrl: 'https://apps.apple.com/de/app/id1483372895')
          }
        }
        });
    });
  }
}

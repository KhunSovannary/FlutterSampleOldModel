import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class App {
  // API
//   static const apiBaseUrl = 'api.ganzberg.com';
  static const apiBaseUrl = "gangos1.kasegro.com";

  static const login = '/api/login';
  static const logout = '/api/logout';
  static const register = '/api/register';
  static const getOtpCode = '/api/get-otp-code';

  static const forgetPassword = '/api/forget-password';
  static const getOtpForgetPassword = '/api/forget-password/get-otp-code';
  static const verifyOtpForgetPassword = '/api/forget-password/verify-otp-code';

  static const publicHome = '/api/public/home';
  static const publicProduct = '/api/public/products';

  //product
  static const productDetail = '/api/products';
  static const publicSearch = '/api/public/search';

  //category
  static const categoryProduct = '/api/categories/products';

  //query name
  static const queryName = '/api/public/filter';

  //order
  static const orderDetail = '/api/orders';
  static const shopOrderList = '/api/orders/get-shop-order-list';
  static const myOrderList = 'api/orders/get-my-order-list';
  // shop order
  static const updateOrderStatus = '/api/orders/update-order';

  // load config
  static const publicLoadConfig = '/api/public/config';

  //checkout
  static const getCheckout = '/api/checkouts';
  static const placeOrder = '/api/orders/execute-order';

  //city
  static const city = '/api/provinces';

  static const iconsThem = IconThemeData(color: Colors.orange);

  // final double itemHeight = MediaQuery.of(context).size.width * 0.65;
  // final double itemWidth = MediaQuery.of(context).size.width / 2;
  static double itemHeight(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.65;
  static double itemWidth(BuildContext context) =>
      MediaQuery.of(context).size.width / 2;

  static final snackBarUnselectProductOption = SnackBar(
      content: Text(
        'Please Select Product Option.',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black87,
      margin: const EdgeInsets.only(bottom: 50, left: 40, right: 40),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))));

  static final snackBarMessage = SnackBar(
      content: Text(
        'Please add products before go to shopping cart',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black87,
      margin: const EdgeInsets.only(bottom: 30, left: 40, right: 40),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))));

  static Map<int, Color> bgStatusColor = {
    0: Colors.yellow.shade200,
    1: Colors.red.shade200,
    2: Colors.green.shade100,
    3: Colors.blue.shade100,
    4: Colors.red.shade200
  };

  static Map<int, Color> textStatusColor = {
    0: Colors.orange,
    1: Colors.red,
    2: Colors.green,
    3: Colors.green,
    4: Colors.red
  };

  static const Map<int, String> status = {
    0: 'Initiate',
    1: 'Pending',
    2: 'Delivery',
    3: 'Completed',
    4: 'Cancelled'
  };


  Future<void> showLoading(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          insetPadding: EdgeInsets.symmetric(horizontal: 160),
          content: SizedBox(
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.grey),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> viewImage(
      {BuildContext context, String image, String title}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Image.network(
              image,
              errorBuilder: (context, exception, stackTrack) =>
                  Image.asset('images/placeholder.png'),
            )),
          ),
        );
      },
    );
  }

  Future<void> showMessageDialog(
      {BuildContext context,
      String title,
      String message,
      IconData icon}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                icon == Icons.check
                    ? Center(
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Colors.green.shade400,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.green.shade100,
                                    spreadRadius: 20),
                              ],
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 70,
                                  )
                                ])),
                      )
                    : Icon(
                        icon,
                        color: Colors.yellow,
                        size: 70,
                      ),
                SizedBox(
                  height: 20,
                ),
                Center(child: Text(message)),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showUpdate({BuildContext context,String message, String appUrl, String title}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).newVersion),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).updateNow),
              onPressed: () async {
                String url = appUrl;
                await canLaunch(url) ? await launch(url) : throw 'Could not launch App';
              },
            ),
          ],
        );
      },
    );
  }
}

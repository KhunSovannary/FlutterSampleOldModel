import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/location_model.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:flutter_chabhuoy/repository/checkout_repository.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_chabhuoy/screens/order_successfully_screen.dart';
import 'package:flutter_chabhuoy/widgets/apply_couple_widget.dart';
import 'package:flutter_chabhuoy/widgets/cart_list_item_widget.dart';
import 'package:flutter_chabhuoy/widgets/checkout_method_widget.dart';
import 'package:flutter_chabhuoy/widgets/request_date_widget.dart';
import 'package:flutter_chabhuoy/widgets/sub_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    @required this.location,
    @required this.user,
  });

  final LocationModel location;
  final User user;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final App myApp = App();

  TextEditingController _controllerDate;
  TextEditingController _controllerTime;

  final DateTime now = DateTime.now();
  //String _initialValue;
  String _valueTime = DateTime.now().toString().split(' ')[1].split('.')[0];
  String _valueDate = DateTime.now().toIso8601String().split('T')[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerDate.dispose();
    _controllerTime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CartRepository>(context);
    final checkoutRepository = Provider.of<CheckoutRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: Colors.orange, //change your color here
        ),
        title: Text(AppLocalizations.of(context).orderConfirmation, style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SubTextWidget(title: AppLocalizations.of(context).subTotal, price: cartItem.totalAmount),
                      SubTextWidget(title: AppLocalizations.of(context).discount, price: 0,),
                      SubTextWidget(title: AppLocalizations.of(context).vat, price: 0,),
                      SubTextWidget(title: AppLocalizations.of(context).deliveryFee, price: 0,),
                      Divider(),
                      SubTextWidget(
                        title: AppLocalizations.of(context).total,
                        textStyleTitle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        price: cartItem.totalAmount,
                        textStylePrice: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              ApplyCouponWidget(),
              CartListItemWidget(),
              CheckoutMethodWidget(title: AppLocalizations.of(context).deliveryMethod, text: 'Ganzberge Delivery', price: 0.00),
//              CheckoutMethodWidget(title: AppLocalizations.of(context).paymentMethod, text: 'Cash on Delivery', price: 0.00),
              RequestDateWidget(
                title: AppLocalizations.of(context).dateTime,
                initValueDate: _valueDate,
                textControllerDate: _controllerDate,
                functionDate: (val) {
                  setState((){
                    _valueDate = val;
                  });
                },
                initValueTime: _valueTime,
                textControllerTime: _controllerTime,
                functionTime: (val) {
                  setState((){
                    _valueTime = val;
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.location_on, color: Colors.orange, size: 40),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${AppLocalizations.of(context).deliveryTo} ${widget.user.fullName ?? ''}', style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),),
                          Text(widget.location.addressLine ?? '')
                        ],
                      ),
                    )
                  ],
                )
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 20,),
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                onPressed: () => {
                  myApp.showLoading(context),
                  checkoutRepository.executeOrder(
                    items: cartItem.items,
                    user: widget.user,
                    location: widget.location,
                    pickUpDate: _valueDate,
                    pickUpTime: _valueTime
                  ).then((response) => {
                    // print(response.msg),
                    Navigator.pop(context),
                    if (response.httpCode == 200 || response.httpCode == 201) {
                       cartItem.clear(),
                       Navigator.pop(context),
                        Navigator.pop(context),
                        Navigator.pop(context),
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderSuccessfullyScreen(orderId: (response.data),)),
                        )
                    }
                    else if (response.httpCode == 500) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        )
                    } else {
                      myApp.showMessageDialog(context: context, message: response.msg)
                    }
                  })
                },
                child: Text(AppLocalizations.of(context).placeOrder, style: TextStyle(
                    color: Colors.white, fontSize: 16
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


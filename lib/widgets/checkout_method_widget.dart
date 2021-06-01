import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/checkout_model.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:flutter_chabhuoy/repository/checkout_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutMethodWidget extends StatefulWidget {
  CheckoutMethodWidget({@required this.title, @required this.text, @required this.price});

  final String title;
  final String text;
  final double price;

  @override
  _CheckoutMethodWidgetState createState() => _CheckoutMethodWidgetState();
}

class _CheckoutMethodWidgetState extends State<CheckoutMethodWidget> {
  int _groupPayment = 1;
  int _groupDelilvery = 1;

  Gateway paymentGatway;
  Delivery deliveryOption;

  @override
  Widget build(BuildContext context) {
    final checkoutRepository = Provider.of<CheckoutRepository>(context);
    final cartRepository = Provider.of<CartRepository>(context);

    return FutureBuilder<CheckoutModel>(
        future: checkoutRepository.getCheckout(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_){
              if (checkoutRepository.paymentGateway == null || checkoutRepository.deliveryOption == null ) {
                checkoutRepository.setPaymentGateway(snapshot.data.data.paymentOptions.gateway[0]);
                checkoutRepository.setDeliveryOption(snapshot.data.data.deliveryOptions.delivery[0]);
              }
            });

            return Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).paymentMethod, style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),),
                        Column(
                          children: snapshot.data.data.paymentOptions.gateway.map((payment) => Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: customRadioButton(
                                  title: payment.name,
                                  value: payment.id,
                                  groupValue: _groupPayment,
                                  onChanged: (newValue) => {
                                    checkoutRepository.setPaymentGateway(payment),
                                    setState(() => {
                                      _groupPayment = newValue
                                    }),
                                  }
                              ),
                            ),
//                            Text('\$ ${widget.price.toStringAsFixed(2)}', style: TextStyle(
//                                fontWeight: FontWeight.bold, fontSize: 16
//                            ),)
                          ],
                        )).toList(),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).deliveryMethod, style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),),
                        Column(
                          children: snapshot.data.data.deliveryOptions.delivery.map((delivery) => Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: customRadioButton(
                                    title: delivery.name,
                                    value: delivery.id,
                                    groupValue: _groupDelilvery,
                                    onChanged: (newValue) => {
                                      checkoutRepository.setDeliveryOption(delivery),
                                      cartRepository.setDeliveryFee(delivery.cost),
                                      setState(() => {
                                        _groupDelilvery = newValue
                                      })
                                    }
                                ),
                              ),
                              Text('\$ ${delivery.cost.toStringAsFixed(2)}', style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16
                              ),)
                            ],
                          )).toList()
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Container();
        }
    );
  }

  Widget customRadioButton({String title, int value,int groupValue,Function onChanged}) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Colors.orange
      ),
      child: RadioListTile(
        contentPadding: const EdgeInsets.all(0),
        activeColor: Colors.orange,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(title),
      ),
    );
  }
}

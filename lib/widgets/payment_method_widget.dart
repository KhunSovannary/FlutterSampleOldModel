import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/payment_method_model.dart';
import 'package:flutter_chabhuoy/repository/payment_method_repository.dart';
import 'package:provider/provider.dart';

class PaymentMethodWidget extends StatelessWidget {
  final App myApp = App();

  @override
  Widget build(BuildContext context) {
    final paymentMethodRepository =
        Provider.of<PaymentMethodRepository>(context, listen: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Cash on Delivery',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              FutureBuilder<PaymentMethods>(
                  future: paymentMethodRepository.getPayment(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                          children: snapshot.data.qrcode
                              .map((qrCode) => Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          qrCode.name,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        TextButton(
                                            onPressed: () => {
                                                  myApp.viewImage(
                                                      context: context,
                                                      image: qrCode.qrImage)
                                                },
                                            child: Text('Open QR Code'))
                                      ],
                                    ),
                                  ))
                              .toList());
                    }
                    return SizedBox(height: 10);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/payment_method_model.dart';
import 'package:flutter_chabhuoy/repository/payment_method_repository.dart';
import 'package:provider/provider.dart';

class QRCodeScreen extends StatelessWidget {
  final App myApp = App();

  @override
  Widget build(BuildContext context) {
    final paymentMethodRepsitory =
        Provider.of<PaymentMethodRepository>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          iconTheme: App.iconsThem,
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            'QR Code',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: FutureBuilder<PaymentMethods>(
            future: paymentMethodRepsitory.getPayment(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: snapshot.data.qrcode
                          .map((qrCode) => InkWell(
                                onTap: () {
                                  myApp.viewImage(
                                      context: context,
                                      image: qrCode.qrImage,
                                      title: qrCode.name);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Image.network(
                                              qrCode.qrImage ?? '',
                                              errorBuilder: (context, exception,
                                                      stackTrack) =>
                                                  Image.asset(
                                                      'images/placeholder.png'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Flexible(
                                            flex: 3, child: Text(qrCode.name))
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('No Data'),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

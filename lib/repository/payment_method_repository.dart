import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/models/payment_method_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentMethodRepository with ChangeNotifier {
  final _storage = FlutterSecureStorage();
  PaymentMethods paymentMethods = PaymentMethods();


  Future<PaymentMethods> getPayment() async {
    String strPayment = '';
    strPayment = await _storage.read(key: 'paymentMethod');
    paymentMethods = PaymentMethods.fromJson(jsonDecode(strPayment));

    return paymentMethods;
  }

}
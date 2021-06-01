import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/checkout_model.dart';
import 'package:flutter_chabhuoy/models/location_model.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CheckoutRepository with ChangeNotifier {

  final _storage = FlutterSecureStorage();

  Gateway paymentGateway;
  Delivery deliveryOption;

  void setPaymentGateway(Gateway gateway) {
    paymentGateway = Gateway(id: gateway.id, name: gateway.name);
    notifyListeners();
  }

  void setDeliveryOption(Delivery delivery) {
    deliveryOption = Delivery(id: delivery.id, name: delivery.name, cost: delivery.cost);
    notifyListeners();
  }

  Future<CheckoutModel> getCheckout() async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');

      final response = await http.get(
        Uri.https(App.apiBaseUrl, App.getCheckout),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $token'
        },
      );
      return CheckoutModel.fromJson(jsonDecode(response.body));
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<ResponseModel> executeOrder({
    List<CartItem> items,
    LocationModel location,
    User user,
    String pickUpDate,
    String pickUpTime}) async {

    try {
      String token = '';
      token = await _storage.read(key: 'token');

      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.placeOrder),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "order_flag":1,
          "delivery_option":"1",
          "address_full_name":"none",
          "address_email": "none",
          "address_phone": user.phone,
          "address_street_address": location.fullAddress,
          "address_city_province_id":1,
          "address_district_id":1,
          "phone_pickup": user.phone,
          "preferred_delivery_pickup_date":  pickUpDate,
          "preferred_delivery_pickup_time":   pickUpTime,
          "payment_method_id": paymentGateway.id,
          "delivery_pickup_date" : pickUpDate,
          "pickup_lat": location.lat,
          "pickup_lon": location.lng,
          "delivery_option_id" : deliveryOption.id,
          "date_order_paid": pickUpDate,
          "note":"noted",
          "total_use_point":0,
          "discount" : [],
          "deliveryOption": deliveryOption.toJson(),
          "paymentOption" : paymentGateway.toJson(),
          "orderItem": List<dynamic>.from(items.map((x) => x.toJson()))
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseModel.fromJson(jsonDecode(response.body), jsonDecode(response.body)['data']['order_id'], response.statusCode);
      }

      return ResponseModel.fromJson(jsonDecode(response.body), [], response.statusCode);
    } catch (error) {
      print('Error : $error}');
    }
  }
}
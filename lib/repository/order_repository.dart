import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class OrderRepository with ChangeNotifier {

  final _storage = FlutterSecureStorage();

  Future<List<OrderModel>> getMyOrders({BuildContext context, dynamic status}) async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');
      final response = await http.get(
        Uri.https(App.apiBaseUrl, '${App.myOrderList}/$status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return List<OrderModel>.from(jsonDecode(response.body)['data']['orders'].map((x) => OrderModel.fromJson(x)));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      print(e);
      throw Exception('error : ${e.toString()}');
    }

  }

  Future<OrderDetailModel> getOrderDetail({BuildContext context,int orderId}) async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');
      final response = await http.get(
        Uri.https(App.apiBaseUrl, '${App.orderDetail}/$orderId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return OrderDetailModel.fromJson(jsonDecode(response.body));
      } else {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      print(e);
      throw Exception('error : ${e.toString()}');
    }

  }
}
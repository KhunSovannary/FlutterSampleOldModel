import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/models/shop_order_list_model.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MyShopOrderRepository with ChangeNotifier {
  final _storage = FlutterSecureStorage();

  Future<ShopOrderListModel> getShopOrderList(
      {BuildContext context, dynamic status}) async {
    String token = '';
    token = await _storage.read(key: 'token');
    final response = await http.get(
      Uri.https(App.apiBaseUrl, '${App.shopOrderList}/${status ?? 'all'}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return ShopOrderListModel.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 500) {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      throw Exception('Failed');
    }
  }

  Future<ResponseModel> updateOrderStatus({int orderId, int statusId}) async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.updateOrderStatus),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'order_id': orderId, 'order_status_id': statusId}),
      );

      return ResponseModel.fromJson(
          jsonDecode(response.body), [], response.statusCode);
    } catch (e) {
      throw Exception('error');
    }
  }
}

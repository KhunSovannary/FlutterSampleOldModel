import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepository with ChangeNotifier {
  final _storage = FlutterSecureStorage();

  User userModel = User();

  void setUser (User user) {
    userModel = user;
    notifyListeners();
  }

  User get getUser {
    return userModel;
  }

  bool get isAuthenticated {
    if (userModel != null)
    return false;
  }

  Future<ResponseModel> login(String phone, String password, String fcmToken, String deviceType) async {
    final response = await http.post(
      Uri.https(App.apiBaseUrl, App.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Content-Language' : 'en'
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
        'password': password,
        'fcm_token': fcmToken,
        'device_type': deviceType,
      }),
    );

    if (response.statusCode == 200) {
      userModel = User.fromJson(jsonDecode(response.body)['data']['user']);
      _storage.write(key: 'user', value: jsonEncode(jsonDecode(response.body)['data']['user']));
      _storage.write(key: 'paymentMethod', value: jsonEncode(jsonDecode(response.body)['data']['payment_methods']));
      _storage.write(key: 'token', value: jsonDecode(response.body)['data']['token'].toString());
      return ResponseModel.fromJson(jsonDecode(response.body), userModel, response.statusCode);
    } else {
      return ResponseModel.fromJson(jsonDecode(response.body), userModel, response.statusCode);
    }
  }

  Future<ResponseModel> logout() async {
    final response = await http.post(
      Uri.https(App.apiBaseUrl, App.logout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Content-Language' : 'en'
      },
    );

    await _storage.deleteAll();
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(jsonDecode(response.body), [], response.statusCode);
    } else {
      return ResponseModel.fromJson(jsonDecode(response.body), [], response.statusCode);
    }
  }



}
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';

class RegisterRepository with ChangeNotifier {
  Future<ResponseModel> register(dynamic user,String verifyCode) async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'full_name' : user['name'],
          'password' : user['password'],
          'phone': user['phone'],
          'verified_request_id': user['requestId'],
          'verified_code': verifyCode,
          'fcm_token' : user['fcm_token'],
          'device_type': Platform.isIOS ? 'ios' : 'android',
        }),
      );

      return ResponseModel.fromJson(jsonDecode(response.body), [], response.statusCode);
    } catch (e) {
      throw Exception('Opp there an error');
    }
  }
}
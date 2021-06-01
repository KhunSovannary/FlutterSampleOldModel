import 'dart:io' show Platform;
import 'dart:convert';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/services/notification_service.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordRepository {

  final NotificationService notificationService = NotificationService();

  Future<ResponseModel> resetPassword({String phone, String password}) async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.forgetPassword),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
          'fcm_token': notificationService.getFCMToken,
          'device_type': Platform.isIOS ? 'ios' : 'android',
        }),
      );

      return ResponseModel.fromJson(jsonDecode(response.body), [], response.statusCode);
    } catch(e) {
      throw Exception('Opp there an error');
    }
  }
}
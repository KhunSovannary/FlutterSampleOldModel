import 'dart:convert';

import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:http/http.dart' as http;

class OtpCodeRepository {

  Future<ResponseModel> getOtpCode({String phone}) async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.getOtpCode),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
        }),
      );

      return ResponseModel.fromJson(jsonDecode(response.body),
          response.statusCode == 200 ? jsonDecode(response.body)['data']['verify_request_id'] : 0,
          response.statusCode);
    } catch(e) {
      throw Exception('Opp there an error : $e');
    }
  }

  Future<ResponseModel> getOtpForgetPassword({String phone}) async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.getOtpForgetPassword),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
        }),
      );

      return ResponseModel.fromJson(jsonDecode(response.body),
          jsonDecode(response.body)['data']['verify_request_id'],
          response.statusCode);
    } catch(e) {
      throw Exception('Opp there an error : $e');
    }
  }

  Future<ResponseModel> verifyOtpForgetPassword({String requestId, String verifyCode}) async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.verifyOtpForgetPassword),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'verified_request_id': requestId,
          'verified_code': verifyCode,
        }),
      );

      return ResponseModel.fromJson(jsonDecode(response.body), [], response.statusCode);
    } catch(e) {
      throw Exception('Opp there an error');
    }
  }
}
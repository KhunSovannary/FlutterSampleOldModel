import 'dart:convert';

import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/models/supplier_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SupplierRepository {

  final _storage = FlutterSecureStorage();

  Future<ResponseModel> getSupplier({int districtId, int membershipId}) async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');

      final response = await http.get(
        Uri.https(
          App.apiBaseUrl,
          '${App.getShopSupplier}/$districtId/$membershipId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $token'
          //'Content-language' : locale.toString()
        },
      );

      return ResponseModel.fromJson(
          jsonDecode(response.body),
          List<SupplierModel>.from(jsonDecode(response.body)['data']['Suppliers'].map((x) => SupplierModel.fromJson(x))),
          response.statusCode);
    } catch(e) {
      throw Exception('Exception : $e');
    }
  }
}
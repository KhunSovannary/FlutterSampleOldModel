import 'dart:convert';

import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/district_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DistrictRepository {
  final _storage = FlutterSecureStorage();

  Future<List<DistrictModel>> getDistrict({int cityId}) async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');

      final response = await http.get(
        Uri.https(
          App.apiBaseUrl,
          '${App.district}/$cityId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $token'
          //'Content-language' : locale.toString()
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return List<DistrictModel>.from(jsonDecode(response.body)['data']['Districts'].map((x) => DistrictModel.fromJson(x)));
      } else if (response.statusCode == 500) {

      } else {
        throw Exception('Error');
      }
    } catch(e) {
      throw Exception('Exception : $e');
    }
  }
}
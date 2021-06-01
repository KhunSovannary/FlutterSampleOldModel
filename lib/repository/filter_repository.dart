import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:http/http.dart' as http;

class FilterRepository {
  Future<List<ProductModel>> searchProduct({String query, Locale locale}) async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.publicSearch),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Content-language': locale.toString() ?? 'en'
        },
        body: jsonEncode({
          "id": "093216",
          "token": "GanGosFutureToken2020",
          "limit": '100',
          "name": query
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 200) {
        return List<ProductModel>.from(jsonDecode(response.body)['data']
                ['products']
            .map((x) => ProductModel.fromJson(x)));
      } else {
        throw Exception('Failed !');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

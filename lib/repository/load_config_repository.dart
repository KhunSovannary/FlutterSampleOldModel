import 'dart:convert';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/load_config_model.dart';
import 'package:http/http.dart' as http;

class LoadConfigRepository {
  Future<LoadConfigModel> appConfig() async {
    try {
      final response = await http.post(
        Uri.https(App.apiBaseUrl, App.publicLoadConfig),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String>{
          "id":"078820",
          "token":"GanGosFutureToken2020"
        }),
      );

      print(response.statusCode);
      return LoadConfigModel.fromJson(jsonDecode(response.body));
    } catch(e) {
      throw Exception('Opp there an error $e');
    }
  }
}
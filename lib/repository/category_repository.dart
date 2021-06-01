import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/category_model.dart';
import 'package:flutter_chabhuoy/models/category_product_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepository with ChangeNotifier {
  Future<CategoryProductModel> fetchCategoryById({int categoryId, Locale locale}) async {
    try {
      var queryParam = {"page": 1.toString()};

      final response = await http.get(
        Uri.https(
          App.apiBaseUrl,
          '${App.categoryProduct}/$categoryId',
          queryParam,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
           'Content-language' : locale.toString()
        },
      );

      // print(jsonDecode(response.body)['data'][0]);
      return CategoryProductModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw ('error : ${e.toString()}');
    }
  }
}

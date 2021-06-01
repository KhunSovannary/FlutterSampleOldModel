import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/product_detail_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/models/query_product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository with ChangeNotifier {
  List<ProductModel> products = [];
  List<QueryModel> filterProduct = [];
  int pageProduct = 1;

  List<ProductModel> get getListProducts {
    return products;
  }

  List<QueryModel> get getFilterProduct {
    return filterProduct;
  }

  int get getLengthProduct {
    return products.length;
  }

  Future<ProductDetailModel> getProductDetail({int productId}) async {
    final response = await http
        .get(Uri.https(App.apiBaseUrl, '${App.productDetail}/$productId'));

    if (response.statusCode == 200) {
      return ProductDetailModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> getProducts({Locale locale, int page}) async {
    // print(products.length);
    // pageProduct = (products.length ~/ 10).toInt();
    if (products.length >= 10) {
      ++pageProduct;
    }

    var queryParam = {
      "id": "093216",
      "token": "GanGosFutureToken2020",
      // "page": page != null ? pageProduct.toString() : 1.toString()
      "page": pageProduct.toString()
    };

    List<ProductModel> _listProduct = [];
    final response = await http
        .get(Uri.https(
        App.apiBaseUrl,
        App.publicProduct, queryParam),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Content-language' : locale.toString()
        },);

    if (response.statusCode == 200) {
      _listProduct = List<ProductModel>.from(jsonDecode(response.body)['data']
              ['products']
          .map((x) => ProductModel.fromJson(x)));
      if (page == null) {
        products = _listProduct;
      } else {
        products.addAll(_listProduct);
      }
      notifyListeners();
    }
  }

  Future<List<ProductModel>> getPublicProduct() async {
    var queryParam = {"id": "093216", "token": "GanGosFutureToken2020"};

    final response = await http
        .get(Uri.https(App.apiBaseUrl, App.publicProduct, queryParam));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return List<ProductModel>.from(jsonDecode(response.body)['data']
              ['products']
          .map((x) => ProductModel.fromJson(x)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> getFilterName({String name}) async {
    try {
      final response = await http.get(Uri.https(App.apiBaseUrl, App.queryName));

      if (response.statusCode == 200) {
        filterProduct = List<QueryModel>.from(jsonDecode(response.body)['data']
            .map((x) => QueryModel.fromJson(x)));
      } else {
        filterProduct = [];
      }
    } catch (e) {
      throw Exception(e);
    }

    notifyListeners();
  }
}

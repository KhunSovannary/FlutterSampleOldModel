import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/banner_model.dart';
import 'package:flutter_chabhuoy/models/category_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chabhuoy/models/home_model.dart';

class HomeRepository with ChangeNotifier{

  List<CategoryModel> categories = [];
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  int get countCategory => categories.length;
  int get countBanner => banners.length;
  int get countProduct => products.length;

  List<CategoryModel> get getCategories => categories;
  List<BannerModel> get getBanner => banners;
  List<ProductModel> get getProduct => products;

  Future<void> getHome(Locale locale) async {
    var queryParam = {
      "id" : "093216",
      "token" : "GanGosFutureToken2020"
    };

    final response = await http.get(Uri.https(
        App.apiBaseUrl,
        App.publicHome,
        queryParam),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Content-language' : locale.toString()
        },);

    if (response.statusCode == 200) {
      banners = List<BannerModel>.from(jsonDecode(response.body)['data']['banners'].map((x) => BannerModel.fromJson(x)));
      categories = List<CategoryModel>.from(jsonDecode(response.body)['data']["categories"].map((x) => CategoryModel.fromJson(x)));
      products = List<ProductModel>.from(jsonDecode(response.body)['data']["new_products"].map((x) => ProductModel.fromJson(x)));
      notifyListeners();
    }
  }

  Future<HomeModel> getPublicHome() async {
    var queryParam = {
      "id" : "093216",
      "token" : "GanGosFutureToken2020"
    };

    final response = await http.get(Uri.https(
        App.apiBaseUrl, App.publicHome, queryParam));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return HomeModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
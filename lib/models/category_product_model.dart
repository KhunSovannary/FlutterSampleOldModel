import 'dart:convert';

import 'package:flutter_chabhuoy/models/category_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';

class CategoryProductModel {
  CategoryProductModel({
    this.status,
    this.message,
    this.data,
    this.request,
  });

  bool status;
  String message;
  Data data;
  Request request;

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"][0]),
      );
}

class Data {
  Data({
    this.id,
    this.defaultName,
    this.imageName,
    this.subCategories,
    this.products,
  });

  int id;
  String defaultName;
  String imageName;
  List<CategoryModel> subCategories;
  List<ProductModel> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        defaultName: json['default_name'],
        imageName: json["image_name"],
        subCategories: List<CategoryModel>.from(
            json["sub_categories"].map((x) => CategoryModel.fromJson(x))),
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
      );
}

class Request {
  Request({
    this.limit,
    this.page,
    this.totalPages,
  });

  int limit;
  int page;
  int totalPages;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        limit: json["limit"],
        page: json["page"],
        totalPages: json["total_pages"],
      );
}

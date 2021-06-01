import 'package:flutter_chabhuoy/models/banner_model.dart';
import 'package:flutter_chabhuoy/models/brand_model.dart';
import 'package:flutter_chabhuoy/models/category_model.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';

class HomeModel {
  HomeModel({
    this.randomProducts,
    this.newProducts,
    this.categories,
    this.banners,
  });

  List<ProductModel> randomProducts;
  List<ProductModel> newProducts;
  List<CategoryModel> categories;
//  List<BrandModel> brands;
  List<BannerModel> banners;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    randomProducts: List<ProductModel>.from(json["random_products"].map((x) => ProductModel.fromJson(x))),
//    promotedProducts: List<ProductModel>.from(json["random_products"].map((x) => ProductModel.fromJson(x))),
    newProducts: List<ProductModel>.from(json["new_products"].map((x) => ProductModel.fromJson(x))),
    categories: List<CategoryModel>.from(json["categories"].map((x) => CategoryModel.fromJson(x))),
//    brands: List<BrandModel>.from(json["brands"].map((x) => BrandModel.fromJson(x))),
    banners: List<BannerModel>.from(json["banners"].map((x) => BannerModel.fromJson(x))),
  );
}
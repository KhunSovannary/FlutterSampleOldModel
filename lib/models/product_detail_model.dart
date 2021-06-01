import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/models/shop_model.dart';

class ProductDetailModel {
  ProductDetailModel({
    this.product,
    this.shop,
    this.sellerProduct,
    this.relatedProduct,
  });

  ProductModel product;
  ShopModel shop;
  List<ProductModel> sellerProduct;
  List<ProductModel> relatedProduct;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
    product: ProductModel.fromJson(json["products"][0]),
    shop: ShopModel.fromJson(json["shop"][0]),
//    products: ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
//    shop: List<ShopModel>.from(json["shop"].map((x) => ShopModel.fromJson(x))),
    sellerProduct: List<ProductModel>.from(json["related_product"].map((x) => ProductModel.fromJson(x))),
    relatedProduct: List<ProductModel>.from(json["related_product"].map((x) => ProductModel.fromJson(x))),
  );
}
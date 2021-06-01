import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/models/status_model.dart';

class ShopOrderListModel {
  ShopOrderListModel({
    this.shop,
    this.orders,
    this.stat,
  });

  dynamic shop;
  List<OrderModel> orders;
  StatusModel stat;

  factory ShopOrderListModel.fromJson(Map<String, dynamic> json) => ShopOrderListModel(
    shop: json["shop"],
    orders: List<OrderModel>.from(json["orders"].map((x) => OrderModel.fromJson(x))),
//    stat: [],
//    stat: StatusModel.fromJson(json["stat"]),
  );
}

import 'dart:convert';

import 'package:flutter_chabhuoy/models/order_item_model.dart';
import 'package:flutter_chabhuoy/models/order_model.dart';
import 'package:flutter_chabhuoy/models/shop_model.dart';
import 'package:flutter_chabhuoy/models/user_model.dart';


class OrderDetailModel {
  OrderDetailModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.user,
    this.shop,
    this.order,
    this.orderItem,
    this.deliveryOption,
    this.discounts,
    this.vat,
  });

  User user;
  dynamic shop;
  OrderModel order;
  List<OrderItem> orderItem;
  DeliveryOption deliveryOption;
  Discounts discounts;
  int vat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    shop: json["shop"],
    order: OrderModel.fromJson(json["order"]),
    orderItem: List<OrderItem>.from(json["items"].map((x) => OrderItem.fromJson(x))),
    deliveryOption: json["deliveryOption"] != null ? DeliveryOption.fromJson(json["deliveryOption"]) : new DeliveryOption(),
    discounts:  new Discounts(),
//    discounts:  Discounts.fromJson(json["discounts"]),
    vat: json["vat"],
  );
}

class DeliveryOption {
  DeliveryOption({
    this.deliveryId,
    this.deliveryName,
    this.deliveryFee,
  });

  int deliveryId;
  String deliveryName;
  String deliveryFee;

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
    deliveryId: json["delivery_id"],
    deliveryName: json["delivery_name"],
    deliveryFee: json["delivery_fee"],
  );

  Map<String, dynamic> toJson() => {
    "delivery_id": deliveryId,
    "delivery_name": deliveryName,
    "delivery_fee": deliveryFee,
  };
}

class Discounts {
  Discounts({
    this.total,
    this.items,
  });

  dynamic total;
  List<dynamic> items;

  factory Discounts.fromJson(Map<String, dynamic> json) => Discounts(
    total: json["total"],
    items: List<dynamic>.from(json["items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "items": List<dynamic>.from(items.map((x) => x)),
  };
}

class User {
  User({
    this.id,
    this.shopId,
    this.fullName,
    this.sex,
    this.dob,
    this.profileImage,
    this.phone,
    this.cityProvinceId,
    this.districtId,
    this.lastLogin,
    this.isActive,
    this.membershipId,
    this.supplierId,
    this.deviceType,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.lat,
    this.lng,
    this.shop
  });


  int id;
  int shopId;
  String fullName;
  dynamic sex;
  dynamic dob;
  dynamic profileImage;
  String phone;
  int cityProvinceId;
  int districtId;
  dynamic lastLogin;
  int isActive;
  dynamic membershipId;
  dynamic supplierId;
  String deviceType;
  DateTime createdAt;
  DateTime updatedAt;
  String fcmToken;
  ShopModel shop;

  double lat;
  double lng;

  double get latitude => lat;
  double get longitude => lng;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    shopId: json["shop_id"],
    fullName: json["full_name"],
    sex: json["sex"],
    dob: json["dob"],
    profileImage: json["profile_image"],
    phone: json["phone"],
    cityProvinceId: json["city_province_id"],
    districtId: json["district_id"],
    lastLogin: json["last_login"],
    isActive: json["is_active"],
    membershipId: json["membership_id"],
    supplierId: json["supplier_id"],
    deviceType: json["device_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    fcmToken: json["fcm_token"],
    shop: json['shop'] != null ? ShopModel.fromJson(json['shop']) : null
  );
}

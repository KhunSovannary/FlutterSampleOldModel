import 'dart:convert';

import 'package:flutter_chabhuoy/models/shop_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  UserModel({
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
    this.shop,
  });

  int id;
  int shopId;
  String fullName;
  dynamic sex;
  dynamic dob;
  String profileImage;
  String phone;
  int cityProvinceId;
  int districtId;
  dynamic lastLogin;
  int isActive;
  int membershipId;
  int supplierId;
  String deviceType;
  DateTime createdAt;
  DateTime updatedAt;
  String fcmToken;
  ShopModel shop;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    shop: ShopModel.fromJson(json["shop"]),
  );
}
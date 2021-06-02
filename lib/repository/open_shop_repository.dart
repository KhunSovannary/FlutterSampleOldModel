import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/city_model.dart';
import 'package:flutter_chabhuoy/models/district_model.dart';
import 'package:flutter_chabhuoy/models/location_model.dart';
import 'package:flutter_chabhuoy/models/membership_model.dart';
import 'package:flutter_chabhuoy/models/response_model.dart';
import 'package:flutter_chabhuoy/models/shop_model.dart';
import 'package:flutter_chabhuoy/models/supplier_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class OpenShopRepository with ChangeNotifier {
  final _storage = FlutterSecureStorage();

  MembershipModel membershipModel;
  CityModel cityModel;
  DistrictModel districtModel;
  SupplierModel supplierModel;
  LocationModel locationModel;

  MembershipModel get getMembership => membershipModel;
  CityModel get getCity => cityModel;
  DistrictModel get getDistrict => districtModel;
  SupplierModel get getSupplier => supplierModel;
  LocationModel get getLocation => locationModel;

  void setMembership({int id, String name}) {
    membershipModel = MembershipModel(id: id, name: name);
    notifyListeners();
  }

  void setCity({int id, String name}) {
    cityModel = CityModel(id: id, name: name);
    notifyListeners();
  }

  void setDistrict({int id, String name}) {
    districtModel =
        (id == null || name == null) ? null : DistrictModel(id: id, name: name);
    notifyListeners();
  }

  void setSupplier({int id, String name}) {
    supplierModel =
        (id == null || name == null) ? null : SupplierModel(id: id, name: name);
    notifyListeners();
  }

  void setLocation({String address, double lat, double lng}) {
    locationModel = LocationModel(lat: lat, lng: lng, fullAddress: address);
    notifyListeners();
  }

  Future<ResponseModel> openShop(
      {String name,
      String phone,
      String address,
      int cityProvinceId,
      int districtId,
      int membershipId,
      int supplierId,
      int shopCategoryId,
      LocationModel location,
      File logoImage,
      File coverImage}) async {
    try {
      String token = '';
      token = await _storage.read(key: 'token');

      var postUri =
          Uri.parse('https://gangos1.kasegro.com/api/shops/open-shop');
      var request = new http.MultipartRequest(
        "POST",
        postUri,
      );

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      request.headers.addAll(headers);
      print(address);
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['country_id'] = '1';
      request.fields['city_province_id'] = cityProvinceId.toString();
      request.fields['district_id'] = districtId.toString();
      request.fields['address'] = address;
      request.fields['lat'] = location.lat.toString();
      request.fields['lng'] = location.lng.toString();
      request.fields['membership_id'] = membershipId.toString();
      request.fields['supplier_id'] = supplierId.toString();
      request.fields['shop_category_id'] = shopCategoryId.toString();
      var shopLogoImage =
          await http.MultipartFile.fromPath("logo_image", logoImage.path);
      var shopCoverImage =
          await http.MultipartFile.fromPath("cover_image", coverImage.path);

      request.files.add(shopLogoImage);
      request.files.add(shopCoverImage);
      // //Get the response from the server
      final req = await request.send();
      final response = await req.stream.bytesToString();
      print(response);
      _storage.write(
          key: 'shop', value: jsonDecode(response)['data']['shop'].toString());
      return ResponseModel.fromJson(jsonDecode(response), [], req.statusCode);
    } catch (error) {
      print('Error : $error}');
    }
  }
}

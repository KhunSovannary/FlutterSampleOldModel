import 'dart:convert';

import 'package:flutter_chabhuoy/models/shop_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShopRepository {
  final _storage = FlutterSecureStorage();

  Future<ShopModel> getShopInfo() async {
    String user = '';
    user = await _storage.read(key: 'user');

    return ShopModel.fromJson(jsonDecode(user)['shop']);
  }
}
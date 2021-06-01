import 'package:flutter/cupertino.dart';

class LocationModel {
  LocationModel({
    @required this.lat,
    @required this.lng,
    @required this.fullAddress,
    @required this.addressLine
  });

  final double lat;
  final double lng;
  final String fullAddress;
  final String addressLine;
}
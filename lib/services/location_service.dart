import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationService with ChangeNotifier {
  final location = new Location();

  double lat;
  double lng;
  String addressLine;
  String fullAddress;

  double get latitude => lat;
  double get longitude => lng;
  String get getAddressLine => addressLine;
  String get getFullAddress => addressLine;

  getCurrentLocation() async {
    var currentLocation = await location.getLocation();

    final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;
    lat = currentLocation.latitude;
    lng = currentLocation.longitude;
    addressLine = '${first.addressLine}';
    fullAddress = '${first.adminArea}, ${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}';
    notifyListeners();
  }
}
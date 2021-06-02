import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/location_model.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/screens/checkout_screen.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  MapScreen({@required this.location, @required this.popUpBack});

  final LocationModel location;
  final bool popUpBack;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _storage = FlutterSecureStorage();
  User userModel = User();

  void getAuthenticate() async {
    String user = '';
    user = await _storage.read(key: 'user');

    if (user != null) {
      userModel = User.fromJson(jsonDecode(user));
    }

    if (user == '' || user == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAuthenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:
          // Text('asds'),
          GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.lat, widget.location.lng),
          zoom: 18,
        ),
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
        markers: {
          Marker(
              markerId: MarkerId('myMarker'),
              draggable: false,
              position: LatLng(widget.location.lat, widget.location.lng))
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.width * 0.1,
        child: ElevatedButton(
            child: Text(AppLocalizations.of(context).select,
                style: TextStyle(fontSize: 16)),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.orange)))),
            onPressed: () {
              if (widget.popUpBack) {
                Navigator.pop(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                          location: LocationModel(
                              lat: widget.location.lat,
                              lng: widget.location.lng,
                              fullAddress: widget.location.fullAddress,
                              addressLine: widget.location.addressLine),
                          user: userModel)),
                );
              }
            }),
      ),
    );
  }
}

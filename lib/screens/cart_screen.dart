import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/models/location_model.dart';
import 'package:flutter_chabhuoy/screens/map_screen.dart';
import 'package:flutter_chabhuoy/services/location_service.dart';
import 'package:flutter_chabhuoy/widgets/cart_list_item_widget.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final location = new Location();

  double lat;
  double lng;
  String addressLine;
  String fullAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<LocationService>(context);
    if (locationService.latitude == null || locationService.longitude == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        locationService.getCurrentLocation();
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: Colors.orange, //change your color here
        ),
        title: Text(AppLocalizations.of(context).myCart,
            style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CartListItemWidget(),
        ),
      ),
      bottomNavigationBar: Consumer<LocationService>(
        builder: (context, location, __) => CustomButtonWidget(
            title: AppLocalizations.of(context).checkout,
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapScreen(
                          popUpBack: false,
                          location: LocationModel(
                              lat: location.latitude,
                              lng: location.longitude,
                              addressLine: location.getAddressLine,
                              fullAddress: location.getFullAddress),
                        )),
              );
            }),
      ),
    );
  }

  _getCurrentLocation() async {
    var currentLocation = await location.getLocation();
    setState(() {
      lat = currentLocation.latitude;
      lng = currentLocation.longitude;
    });

    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;
    setState(() {
      lat = currentLocation.latitude;
      lng = currentLocation.longitude;
      addressLine = '${first.addressLine}';
      fullAddress =
          '${first.adminArea}, ${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}';
    });
  }
}

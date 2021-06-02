import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/location_model.dart';
import 'package:flutter_chabhuoy/repository/city_repository.dart';
import 'package:flutter_chabhuoy/repository/disctrict_repository.dart';
import 'package:flutter_chabhuoy/repository/membership_repository.dart';
import 'package:flutter_chabhuoy/repository/open_shop_repository.dart';
import 'package:flutter_chabhuoy/repository/supplier_repository.dart';
import 'package:flutter_chabhuoy/screens/map_screen.dart';
import 'package:flutter_chabhuoy/services/location_service.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/custom_list_checkbox.dart';
import 'package:flutter_chabhuoy/widgets/shop_info_field_widget.dart';
import 'package:flutter_chabhuoy/widgets/text_field_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BecameSellerScreen extends StatefulWidget {
  @override
  _BecameSellerScreenState createState() => _BecameSellerScreenState();
}

class _BecameSellerScreenState extends State<BecameSellerScreen> {
  File _logoFile;
  File _coverFile;
  final picker = ImagePicker();

  final App myApp = App();
  final CityRepository cityRepository = CityRepository();
  final DistrictRepository districtRepository = DistrictRepository();
  final MembershipRepository membershipRepository = MembershipRepository();
  final SupplierRepository supplierRepository = SupplierRepository();

  TextEditingController nameTextController = new TextEditingController();
  TextEditingController phoneTextController = new TextEditingController();
  TextEditingController addressTextController = new TextEditingController();

  int _cityId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextController.dispose();
    phoneTextController.dispose();
    addressTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final openShopRepository = Provider.of<OpenShopRepository>(context);
    final locationService = Provider.of<LocationService>(context);
    if (locationService.latitude == null || locationService.longitude == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        locationService.getCurrentLocation();
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: App.iconsThem,
          elevation: 0.5,
          title: Text(
            'Become Seller',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.grey.shade200,
                            child: Text('Shop Information',
                                style: TextStyle(fontSize: 16))),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Shop Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                        'images/ic_shop.png',
                                        scale: 2.4,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      controller: nameTextController,
                                      hintText: 'e.g Chabhouy',
                                      readOnly: false,
                                      hintTextStyle: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Shop Phone',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                        'images/ic_shop.png',
                                        scale: 2.4,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      controller: phoneTextController,
                                      hintText: 'e.g 012 XXX XXX',
                                      readOnly: false,
                                      hintTextStyle: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Membership',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.group,
                                        size: 26,
                                        color: Colors.grey.shade800,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      hintText:
                                          openShopRepository.getMembership !=
                                                  null
                                              ? openShopRepository
                                                  .getMembership.name
                                              : 'Select Membership',
                                      readOnly: true,
                                      hintTextStyle: TextStyle(
                                          color: openShopRepository
                                                      .getMembership !=
                                                  null
                                              ? Colors.black
                                              : Colors.black54,
                                          fontSize: 14),
                                      onTap: () => {
                                        myApp.showLoading(context),
                                        membershipRepository
                                            .getMembership()
                                            .then((value) => {
                                                  Navigator.pop(context),
                                                  showDialog<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CustomListCheckBox(
                                                        data: value,
                                                        stringType:
                                                            'membership',
                                                        title: 'Membership',
                                                      );
                                                    },
                                                  )
                                                })
                                            .onError((error, stackTrace) => {})
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.location_on,
                                        size: 26,
                                        color: Colors.grey.shade800,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      hintText:
                                          openShopRepository.getCity == null
                                              ? 'Select City'
                                              : openShopRepository.getCity.name,
                                      readOnly: true,
                                      hintTextStyle: TextStyle(
                                          color:
                                              openShopRepository.getCity == null
                                                  ? Colors.black54
                                                  : Colors.black,
                                          fontSize: 14),
                                      onTap: () => {
                                        myApp.showLoading(context),
                                        cityRepository
                                            .getCity()
                                            .then((value) => {
                                                  Navigator.pop(context),
                                                  showDialog<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CustomListCheckBox(
                                                        data: value,
                                                        stringType: 'city',
                                                        title: 'City',
                                                      );
                                                    },
                                                  )
                                                })
                                            .onError((error, stackTrace) => {})
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'District',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.location_on,
                                        size: 26,
                                        color: Colors.grey.shade800,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      hintText:
                                          openShopRepository.getDistrict != null
                                              ? openShopRepository
                                                  .getDistrict.name
                                              : 'Select District',
                                      readOnly: true,
                                      hintTextStyle: TextStyle(
                                          color:
                                              openShopRepository.getDistrict !=
                                                      null
                                                  ? Colors.black
                                                  : Colors.black54,
                                          fontSize: 14),
                                      onTap: () => {
                                        if (openShopRepository.getCity == null)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    myApp.getSnackBarMessage(
                                                        message:
                                                            'Please Select City!'))
                                          }
                                        else
                                          {
                                            myApp.showLoading(context),
                                            districtRepository
                                                .getDistrict(
                                                    cityId: openShopRepository
                                                        .getCity.id)
                                                .then((value) => {
                                                      Navigator.pop(context),
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return CustomListCheckBox(
                                                            data: value,
                                                            stringType:
                                                                'district',
                                                            title: 'District',
                                                          );
                                                        },
                                                      )
                                                    })
                                                .onError(
                                                    (error, stackTrace) => {})
                                          }
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Shop Address',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.location_on,
                                        size: 26,
                                        color: Colors.grey.shade800,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      controller: addressTextController,
                                      hintText:
                                          locationService.getFullAddress != null
                                              ? locationService.getFullAddress
                                              : 'Address',
                                      readOnly: false,
                                      hintTextStyle: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Supplier',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.people,
                                        size: 26,
                                        color: Colors.grey.shade800,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      hintText:
                                          openShopRepository.getSupplier != null
                                              ? openShopRepository
                                                  .getSupplier.name
                                              : 'Select Supplier',
                                      readOnly: true,
                                      hintTextStyle: TextStyle(
                                          color:
                                              openShopRepository.getSupplier !=
                                                      null
                                                  ? Colors.black
                                                  : Colors.black54,
                                          fontSize: 14),
                                      onTap: () => {
                                        if (openShopRepository.getDistrict ==
                                                null ||
                                            openShopRepository.getMembership ==
                                                null)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    myApp.getSnackBarMessage(
                                                        message:
                                                            'Please Select District or Membership!'))
                                          }
                                        else
                                          {
                                            myApp.showLoading(context),
                                            supplierRepository
                                                .getSupplier(
                                                    districtId:
                                                        openShopRepository
                                                            .getDistrict.id,
                                                    membershipId:
                                                        openShopRepository
                                                            .getMembership.id)
                                                .then((response) => {
                                                      Navigator.pop(context),
                                                      if (response.httpCode ==
                                                              200 ||
                                                          response.httpCode ==
                                                              201)
                                                        {
                                                          showDialog<void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return CustomListCheckBox(
                                                                data: response
                                                                    .data,
                                                                stringType:
                                                                    'supplier',
                                                                title:
                                                                    'Supplier',
                                                              );
                                                            },
                                                          )
                                                        }
                                                      else if (response
                                                              .httpCode ==
                                                          401)
                                                        {
                                                          myApp
                                                              .showMessageDialog(
                                                                  context:
                                                                      context,
                                                                  title: 'Oop',
                                                                  message:
                                                                      response
                                                                          .msg,
                                                                  icon: Icons
                                                                      .warning)
                                                        }
                                                    })
                                                .onError(
                                                    (error, stackTrace) => {})
                                          }
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.my_location,
                                        size: 26,
                                        color: Colors.grey.shade800,
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: TextFieldWidget(
                                      hintText: locationService.lat == null ||
                                              locationService.lng == null
                                          ? 'Pick Up Location'
                                          : '${locationService.lat} : ${locationService.lng}',
                                      readOnly: true,
                                      hintTextStyle: TextStyle(
                                          color: locationService.lat == null ||
                                                  locationService.lng == null
                                              ? Colors.black54
                                              : Colors.black,
                                          fontSize: 14),
                                      onTap: () => {
                                        if (locationService.lat == null ||
                                            locationService.lng == null)
                                          {myApp.showLoading(context)},
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                  popUpBack: true,
                                                  location: locationService
                                                      .getLocation)),
                                        )
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.grey.shade200,
                            child: Text('Upload Required Document',
                                style: TextStyle(fontSize: 16))),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                _showPicker(
                                    context: context, imageType: 'logo');
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: new BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: _logoFile == null
                                      ? Center(
                                          child: Text('LOGO',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)))
                                      : Image.file(_logoFile)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                _showPicker(
                                    context: context, imageType: 'cover');
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: new BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: _coverFile == null
                                      ? Center(
                                          child: Text('COVER',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)))
                                      : Image.file(
                                          _coverFile,
                                        )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButtonWidget(
                    title: 'Submit',
                    function: () {
                      if (openShopRepository.getCity == null ||
                          openShopRepository.getDistrict == null ||
                          openShopRepository.getMembership == null ||
                          openShopRepository.getSupplier == null) {
                        myApp.showMessageDialog(
                            context: context,
                            message: 'Missing some input!',
                            icon: Icons.warning);
                      } else {
                        myApp.showLoading(context);
                        openShopRepository
                            .openShop(
                                name: nameTextController.text,
                                phone: phoneTextController.text,
                                address: locationService.fullAddress,
                                cityProvinceId: openShopRepository.getCity.id,
                                districtId: openShopRepository.getDistrict.id,
                                membershipId:
                                    openShopRepository.getMembership.id,
                                supplierId: openShopRepository.getSupplier.id,
                                location: locationService.getLocation,
                                shopCategoryId: 0,
                                logoImage: _logoFile,
                                coverImage: _coverFile)
                            .then((response) => {
                                  Navigator.pop(context),
                                  if (response.status)
                                    {
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.check)
                                    }
                                  else
                                    {
                                      myApp.showMessageDialog(
                                          context: context,
                                          message: response.msg,
                                          icon: Icons.warning)
                                    }
                                })
                            .onError((error, stackTrace) => {
                                  // Navigator.pop(context),
                                  myApp.showMessageDialog(
                                      context: context,
                                      message: 'Opp Something Error',
                                      icon: Icons.warning)
                                });
                      }
                    })
              ],
            ),
          ),
        ));
  }

  _imgFromCamera(String imageType) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (imageType == 'logo') {
        _logoFile = image;
      }

      if (imageType == 'cover') {
        _coverFile = image;
      }
    });
  }

  _imgFromGallery(String imageType) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (imageType == 'logo') {
        _logoFile = image;
      }

      if (imageType == 'cover') {
        _coverFile = image;
      }
    });
  }

  void _showPicker({BuildContext context, String imageType}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(imageType);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(imageType);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

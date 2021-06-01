import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/city_repository.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/shop_info_field_widget.dart';
import 'package:flutter_chabhuoy/widgets/text_field_widget.dart';
import 'package:image_picker/image_picker.dart';

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

  TextEditingController nameTextController;
  TextEditingController phoneTextController;
  TextEditingController locationTextController;
  TextEditingController membershipTextController;
  TextEditingController cityTextController;
  TextEditingController districtTextController;
  TextEditingController addressTextController;
  TextEditingController supplierTextController;

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
    locationTextController.dispose();
    membershipTextController.dispose();
    cityTextController.dispose();
    districtTextController.dispose();
    addressTextController.dispose();
    supplierTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: App.iconsThem,
        elevation: 0.5,
        title: Text('Become Seller', style: TextStyle(
          color: Colors.black
        ),),
      ),
      body:SingleChildScrollView(
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
                              style: TextStyle(
                                  fontSize: 16
                              ))
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Shop Name', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.asset('images/ic_shop.png', scale: 2.4,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: nameTextController,
                                    hintText: 'e.g Chabhouy',
                                    readOnly: false,
                                    hintTextStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Shop Phone', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.asset('images/ic_shop.png', scale: 2.4,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: phoneTextController,
                                    hintText: 'e.g 012 XXX XXX',
                                    readOnly: false,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Membership', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.group, size: 26, color: Colors.grey.shade800,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: membershipTextController,
                                    hintText: 'Select Membership',
                                    readOnly: true,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('City', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.location_on, size: 26, color: Colors.grey.shade800,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: cityTextController,
                                    hintText: 'Select City',
                                    readOnly: true,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                    onTap: () => {
                                      cityRepository.getCity()
                                        .then((value) => {
//                                          print(value)
                                            showDialogSelectBox(context: context, title: 'City', data: value)
                                        }).onError((error, stackTrace) => {

                                        })
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('District', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.location_on, size: 26, color: Colors.grey.shade800,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: districtTextController,
                                    hintText: 'Select District',
                                    readOnly: true,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Shop Address', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.location_on, size: 26, color: Colors.grey.shade800,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: addressTextController,
                                    hintText: 'Address',
                                    readOnly: false,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Supplier', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.people, size: 26, color: Colors.grey.shade800,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: supplierTextController,
                                    hintText: 'Select Supplier',
                                    readOnly: true,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Current Location', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 14
                            ),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.my_location, size: 26, color: Colors.grey.shade800,)
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFieldWidget(
                                    controller: locationTextController,
                                    hintText: 'Pick Up Location',
                                    readOnly: true,
                                    hintTextStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
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
              SizedBox(height: 15,),
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
                              style: TextStyle(
                                  fontSize: 16
                              ))
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15,),
                          InkWell(
                            onTap: () {
                              _showPicker(context: context, imageType: 'logo');
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                height: MediaQuery.of(context).size.width * 0.25,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: new BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: _logoFile == null ? Center(
                                    child: Text('LOGO', style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                    ))) : 
                                    Image.file(_logoFile)
                            ),
                          ),
                          SizedBox(width: 15,),
                          InkWell(
                            onTap: () {
                              _showPicker(context: context, imageType: 'cover');
                            },
                            child: Container(
                                height: MediaQuery.of(context).size.width * 0.25,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: _coverFile == null ? Center(
                                    child: Text('COVER', style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold
                                    ))) :
                                    Image.file(_coverFile,)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              CustomButtonWidget(
                  title: 'Submit',
                  function: () {

                  }
              )
            ],
          ),
        ),
      )
    );
  }

  _imgFromCamera(String imageType) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

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
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

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
        }
    );
  }

  Future<void> showDialogSelectBox({BuildContext context, String title, List<dynamic> data, Function function}) async {
    return showDialog<void>(
      context: context,
//      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
//          contentPadding: const EdgeInsets.symmetric(horizontal: 40),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ListBody(
                children: data.map<Widget>((item) => customRadioButton(
                  title: item.name,
                  value: item.id,
                  groupValue: _cityId,
                  onChanged: (newValue) {
                      setState(() {
                        _cityId = newValue;
                      });
                  }
                )).toList(),
              ),
            ),
          ),
//          actions: <Widget>[
//            TextButton(
//              child: const Text('Close'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
        );
      },
    );
  }

  Widget customRadioButton({String title, int value,int groupValue,Function onChanged}) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Colors.orange
      ),
      child: RadioListTile(
        contentPadding: const EdgeInsets.all(0),
        activeColor: Colors.orange,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(title),
      ),
    );
  }
}

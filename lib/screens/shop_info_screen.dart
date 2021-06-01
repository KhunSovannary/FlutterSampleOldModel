import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/shop_model.dart';
import 'package:flutter_chabhuoy/repository/shop_repository.dart';
import 'package:flutter_chabhuoy/screens/view_image_screen.dart';
import 'package:flutter_chabhuoy/widgets/shop_info_field_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShopInfoScreen extends StatelessWidget {
  final ShopRepository shopRepository = ShopRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ShopModel>(
        future: shopRepository.getShopInfo(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return SingleChildScrollView(
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
                            ShopInfoWidget(
                              title: 'Shop name',
                              textFieldHint: snapshot.data.name,
                              textFieldReadonly: true,
                              image: 'images/ic_shop.png',
                            ),
                            ShopInfoWidget(
                              title: 'Shop Phone',
                              textFieldHint: snapshot.data.phone,
                              textFieldReadonly: true,
                              image: 'images/ic_shop.png',
                            ),
                            ShopInfoWidget(
                              title: 'MemberShip',
                              textFieldHint: snapshot.data.membershipName,
                              textFieldReadonly: true,
                              icon: Icons.people,
                            ),
                            ShopInfoWidget(
                              title: 'City/Province',
                              textFieldHint: snapshot.data.city,
                              textFieldReadonly: true,
                              icon: Icons.location_on,
                            ),
                            ShopInfoWidget(
                              title: 'Disctrict',
                              textFieldHint: snapshot.data.district,
                              textFieldReadonly: true,
                              icon: Icons.location_on,
                            ),
                            ShopInfoWidget(
                              title: 'Shop Address',
                              textFieldHint: 'MemberShip',
                              textFieldReadonly: true,
                              icon: Icons.location_on,
                            ),
                            ShopInfoWidget(
                              title: 'Supplier',
                              textFieldHint: snapshot.data.membershipName,
                              textFieldReadonly: true,
                              icon: Icons.supervisor_account,
                            ),
                            ShopInfoWidget(
                              title: 'My Location',
                              textFieldHint: '${snapshot.data.lat} : ${snapshot.data.lng}',
                              textFieldReadonly: true,
                              icon: Icons.my_location,
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
                              children: [
//                                Text(snapshot.data.logoImage),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewImageScreen(image: snapshot.data.logoImage)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: MediaQuery.of(context).size.width * 0.25,
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    child: FadeInImage(
                                      image: NetworkImage(snapshot.data.logoImage),
                                      placeholder: AssetImage(
                                          "images/placeholder.png"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'images/placeholder.png',
                                            fit: BoxFit.fitWidth);
                                      },
                                      fit: BoxFit.fitWidth,
                                    )
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewImageScreen(image: snapshot.data.coverImage)));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      height: MediaQuery.of(context).size.width * 0.25,
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      child: FadeInImage(
                                        image: NetworkImage(snapshot.data.coverImage),
                                        placeholder: AssetImage(
                                            "images/placeholder.png"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'images/placeholder.png',
                                              fit: BoxFit.fitWidth);
                                        },
                                        fit: BoxFit.fitWidth,
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return Center(
              child: CircularProgressIndicator()
          );
        }
    );
  }
}



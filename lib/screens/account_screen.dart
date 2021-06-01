import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/models/order_detail_model.dart';
import 'package:flutter_chabhuoy/models/user_model.dart';
import 'package:flutter_chabhuoy/repository/auth_repository.dart';
import 'package:flutter_chabhuoy/screens/became_seller_screen.dart';
import 'package:flutter_chabhuoy/screens/language_screen.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_chabhuoy/screens/my_order_screen.dart';
import 'package:flutter_chabhuoy/screens/my_shop_screen.dart';
import 'package:flutter_chabhuoy/screens/qr_code_screen.dart';
import 'package:flutter_chabhuoy/screens/root_screen.dart';
import 'package:flutter_chabhuoy/widgets/order_statue_widget.dart';
import 'package:flutter_chabhuoy/widgets/title_inkwell_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _storage = FlutterSecureStorage();

  User userModel = User();
  String name = '';
  String phone = '';
  String appVersion;

  void getAuthenticate() async {
    String user = '';
    user = await _storage.read(key: 'user');

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });

    if (user != null) {
      userModel = User.fromJson(jsonDecode(user));
    }

    if (this.mounted) {
      setState(() {
        name = userModel.fullName ?? '';
        phone = userModel.phone ?? '';
      });
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthRepository>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                      color: Colors.black12,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('images/none-profile.png'),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.08,
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.1,
                                  blurRadius: 6,
                                  offset:
                                      Offset(2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            user.getUser.fullName != null
                                ? user.getUser.fullName
                                : name,
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 6),
                        Text(
                            user.getUser.phone != null
                                ? user.getUser.phone
                                : phone,
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                      color: Colors.black12,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleInkWellWidget(
                            image: 'images/ic_my_order.png',
                            title: AppLocalizations.of(context).myOrder,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyOrderScreen(
                                          orderStatus: 'all',
                                        )),
                              );
                            },
                            child: Text(AppLocalizations.of(context).seeAll),
                          )
                        ],
                      ),
                      OrderStatusWidget(
                        title: AppLocalizations.of(context).processing,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderScreen(
                                      orderStatus: 0,
                                    )),
                          );
                        },
                      ),
                      OrderStatusWidget(
                        title: AppLocalizations.of(context).complete,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderScreen(
                                      orderStatus: 3,
                                    )),
                          );
                        },
                      ),
                      OrderStatusWidget(
                        title: AppLocalizations.of(context).cancelled,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderScreen(
                                      orderStatus: 4,
                                    )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              userModel.shop == null ? SizedBox(
                height: 10,
              ) : Container(),
              userModel == null ? Container() : InkWell(
                onTap: () {
                  if (userModel.shop != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyShopScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BecameSellerScreen()),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.2,
                        color: Colors.black12,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TitleInkWellWidget(
                          image: 'images/ic_shop.png',
                          title: userModel.shop == null ? 'Became a Seller' : AppLocalizations.of(context).myShop,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                      color: Colors.black12,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleInkWellWidget(
                        image: 'images/ic_shop.png',
                        title: AppLocalizations.of(context).point,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRCodeScreen()),
                  )
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.2,
                        color: Colors.black12,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TitleInkWellWidget(
                          iconData: Icons.qr_code,
                          title: AppLocalizations.of(context).qrCode,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.2,
                        color: Colors.black12,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TitleInkWellWidget(
                          iconData: Icons.settings,
                          title: AppLocalizations.of(context).setting,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                      color: Colors.black12,
                    )),
                child: InkWell(
                  onTap: () {
                    if (user.getUser.fullName == null && name == '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    } else {
                      user.setUser(new User());
                      user.logout();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RootScreen()),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TitleInkWellWidget(
                          iconData: Icons.logout,
                          title: user.getUser.fullName == null && name == ''
                              ? AppLocalizations.of(context).signIn
                              : AppLocalizations.of(context).signOut,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('V$appVersion'),
          )
        ],
      ),
    );
  }
}

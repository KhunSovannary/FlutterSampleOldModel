import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/repository/home_repository.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:flutter_chabhuoy/screens/root_screen.dart';
import 'package:flutter_chabhuoy/services/localization_service.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String version = '';
  int _second = 3;
//  ProductRepository productRepository = ProductRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
    Timer.periodic(Duration(seconds: 3), (timer) {
      timer.cancel();
      final productRepository =
          Provider.of<ProductRepository>(context, listen: false);
      final homeRepository =
          Provider.of<HomeRepository>(context, listen: false);
      final localizationService = Provider.of<LocalizationService>(context, listen: false);


      productRepository.getProducts();
      homeRepository.getHome(localizationService.locale);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => RootScreen()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   final productRepository = Provider.of<ProductRepository>(context);
    //   final homeRepository = Provider.of<HomeRepository>(context);

    //   productRepository.getProducts();
    //   homeRepository.getHome();
    // });

    return Scaffold(
//      backgroundColor: Colors.orange.shade500,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset('images/logo.png')),
                    SizedBox(height: 10),
                    Container(
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    child: Text('v$version',
                        style: TextStyle(color: Colors.white)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

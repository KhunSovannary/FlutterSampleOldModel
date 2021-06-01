import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/repository/auth_repository.dart';
import 'package:flutter_chabhuoy/repository/cart_repository.dart';
import 'package:flutter_chabhuoy/repository/checkout_repository.dart';
import 'package:flutter_chabhuoy/repository/home_repository.dart';
import 'package:flutter_chabhuoy/repository/my_shop_order_repository.dart';
import 'package:flutter_chabhuoy/repository/order_repository.dart';
import 'package:flutter_chabhuoy/repository/payment_method_repository.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:flutter_chabhuoy/repository/category_repository.dart';
import 'package:flutter_chabhuoy/screens/product_detail_screen.dart';
import 'package:flutter_chabhuoy/screens/root_screen.dart';
import 'package:flutter_chabhuoy/screens/splash_screen.dart';
import 'package:flutter_chabhuoy/services/localization_service.dart';
import 'package:flutter_chabhuoy/services/location_service.dart';
import 'package:flutter_chabhuoy/services/notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeRepository()),
        ChangeNotifierProvider.value(value: NotificationService()),
        ChangeNotifierProvider.value(value: ProductRepository()),
        ChangeNotifierProvider.value(value: CartRepository()),
        ChangeNotifierProvider.value(value: AuthRepository()),
        ChangeNotifierProvider.value(value: MyShopOrderRepository()),
        ChangeNotifierProvider.value(value: OrderRepository()),
        ChangeNotifierProvider.value(value: PaymentMethodRepository()),
        ChangeNotifierProvider.value(value: CheckoutRepository()),
        ChangeNotifierProvider.value(value: CategoryRepository()),
        ChangeNotifierProvider.value(value: LocationService()),
        ChangeNotifierProvider.value(value: LocalizationService()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocalizationService(),
        builder: (context, child) {
          final localizationService = Provider.of<LocalizationService>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: localizationService.locale,
            supportedLocales: L10n.all,
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => SplashScreen(),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/product-detail': (context) => ProductDetailScreen(),
            },
          );
        }
      ),
    );
  }
}

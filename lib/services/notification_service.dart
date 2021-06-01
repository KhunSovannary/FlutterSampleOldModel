import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/notification_ios_model.dart';
import 'package:flutter_chabhuoy/screens/order_detail_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  print(message);
  // Or do other work.
}

class NotificationService with ChangeNotifier {
  NotificationService._();

  factory NotificationService() => _instance;

  static final NotificationService _instance = NotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  String fcmToke;

  Future<void> init(BuildContext context) async {
    try {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings("ic_launcher");

      IOSInitializationSettings iosInitializationSettings =
          IOSInitializationSettings();

      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: androidInitializationSettings,
              iOS: iosInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onSelectNotification: (String payload) async {
            NotificationModel notificationModel = NotificationModel.fromJson(jsonDecode(payload));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      OrderDetailScreen(orderId: notificationModel.orderId, isSeller: notificationModel.toUser == 'seller' ? true : false)),
                );
          });

      NotificationModel notificationModel;

      if (!_initialized) {
        // For iOS request permission first.
        _firebaseMessaging.requestNotificationPermissions();

        _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
            showNotification(message);
            print("onMessageee: $message");
          },
          onBackgroundMessage: myBackgroundMessageHandler,
          onLaunch: (Map<String, dynamic> message) async {
            NotificationModel notificationModel = NotificationModel.fromJson(message);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  OrderDetailScreen(orderId: notificationModel.orderId, isSeller: notificationModel.toUser == 'seller' ? true : false)),
            );
            print("onLaunch: $message");
          },
          onResume: (Map<String, dynamic> message) async {
            NotificationModel notificationModel = NotificationModel.fromJson(message);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  OrderDetailScreen(orderId: notificationModel.orderId, isSeller: notificationModel.toUser == 'seller' ? true : false)),
            );
            print("onResume: $message");
          },
        );

        _firebaseMessaging.requestNotificationPermissions(
            const IosNotificationSettings(
                sound: true, badge: true, alert: true, provisional: true));

        _firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
          print("Settings registered: $settings");
        });
        _firebaseMessaging.getToken().then((String token) {
          assert(token != null);
          fcmToke = token;
          print(token);
        });

        _initialized = true;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  String get getFCMToken => fcmToke;

  Future selectNotification(dynamic payload) async {
    NotificationModel notificationModel = NotificationModel.fromJson(jsonDecode(payload));
    print(notificationModel.toUser);
  }


  Future<void> showNotification(dynamic notification) async {
    NotificationModel notificationModel;
    notificationModel = NotificationModel.fromJson(notification);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'high_importance_channel', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, notificationModel.title, notificationModel.body, platformChannelSpecifics,
        payload: jsonEncode(notification));
    print(notification);
  }
}

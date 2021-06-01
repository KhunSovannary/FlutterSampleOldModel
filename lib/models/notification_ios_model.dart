import 'dart:io' show Platform;

class NotificationModel {
  NotificationModel({
    this.from,
    this.orderId,
    this.notificationType,
    this.notification,
    this.title,
    this.collapseKey,
    this.notificationAction,
    this.toUser,
    this.body,
    this.isRing,
  });

  String from;
  int orderId;
  String notificationType;
  NotificationData notification;
  String title;
  String collapseKey;
  String notificationAction;
  String toUser;
  String body;
  bool isRing;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        from: Platform.isIOS ? json["from"] : null,
        orderId: Platform.isIOS ? (json["order_id"])  : int.parse(json['data']["order_id"]),
        notificationType: Platform.isIOS
            ? json["notification_type"]
            : json['data']["notification_type"],
        notification: NotificationData(
          title: json["notification"]['title'],
          body: json["notification"]['body']
        ),
        title: Platform.isIOS ? json["title"] : json['data']['title'],
        notificationAction: Platform.isIOS
            ? json["notification_action"]
            : json['data']['notification_action'],
        toUser: Platform.isIOS ? json["to_user"] : json['data']["to_user"],
        body: Platform.isIOS ? json["body"] : json['data']["body"],
        isRing: Platform.isIOS ?
            json["is_ring"].toString().toLowerCase() == 'true' ? true : false
            : json['data']["is_ring"].toString().toLowerCase() == 'true' ? true : false,
      );
}

class NotificationData {
  NotificationData({
    this.body,
    this.title,
  });

  String body;
  String title;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        body: json["body"],
        title: json["title"],
      );
}

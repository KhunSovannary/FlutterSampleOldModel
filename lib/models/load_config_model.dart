import 'package:flutter/cupertino.dart';

class LoadConfigModel {
  String appAndroidVersion;
  String appIOSVersion;
  bool status;
  int updateStatus;
  String message;

  LoadConfigModel({@required this.status, @required this.appAndroidVersion,@required this.appIOSVersion, @required this.updateStatus, @required this.message, });

  String get version => appAndroidVersion;
  int get update => updateStatus;
  String get appMessage => message;

  factory LoadConfigModel.fromJson(Map<String, dynamic> json) => LoadConfigModel(
    status: json["status"],
    appAndroidVersion: json["status"] ? json["data"]['version']['android']['currentVersion'] : '',
    appIOSVersion: json["status"] ? json["data"]['version']['ios']['currentVersion'] : '',
    updateStatus: json["status"] ? json["data"]['version']['android']['updateStatus'] : '',
    message: json["status"] ? json["data"]['version']['android']['message'] : '',
  );
}

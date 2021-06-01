class ResponseModel {
  ResponseModel({
    this.status,
    this.msg,
    this.data,
    this.httpCode
  });

  bool status;
  String msg;
  int httpCode;
  dynamic data;

  factory ResponseModel.fromJson(Map<String, dynamic> json, dynamic data, int code) => ResponseModel(
    status: json["status"],
    msg: json["msg"] != null ? json["msg"] : json["message"],
    httpCode: code,
    data: data,
  );
}

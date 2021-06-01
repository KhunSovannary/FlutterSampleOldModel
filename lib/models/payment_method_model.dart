class PaymentMethods {
  PaymentMethods({
    this.gateway,
    this.qrcode,
  });

  List<Gateway> gateway;
  List<Gateway> qrcode;

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
    gateway: List<Gateway>.from(json["gateway"].map((x) => Gateway.fromJson(x))),
    qrcode: List<Gateway>.from(json["qrcode"].map((x) => Gateway.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gateway": List<dynamic>.from(gateway.map((x) => x.toJson())),
    "qrcode": List<dynamic>.from(qrcode.map((x) => x.toJson())),
  };
}

class Gateway {
  Gateway({
    this.id,
    this.shopId,
    this.name,
    this.qrImage,
    this.iconImage,
    this.description,
  });

  int id;
  int shopId;
  String name;
  String qrImage;
  String iconImage;
  String description;

  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
    id: json["id"],
    shopId: json["shop_id"],
    name: json["name"],
    qrImage: json["qr_image"],
    iconImage: json["icon_image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "name": name,
    "qr_image": qrImage,
    "icon_image": iconImage,
    "description": description,
  };
}

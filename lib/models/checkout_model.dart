class CheckoutModel {
  CheckoutModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.discounts,
    this.paymentOptions,
    this.deliveryOptions,
  });

  List<Discount> discounts;
  PaymentOptions paymentOptions;
  DeliveryOptions deliveryOptions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    discounts: List<Discount>.from(json["discounts"].map((x) => Discount.fromJson(x))),
    paymentOptions: PaymentOptions.fromJson(json["payment_options"]),
    deliveryOptions: DeliveryOptions.fromJson(json["delivery_options"]),
  );

  Map<String, dynamic> toJson() => {
    "discounts": List<dynamic>.from(discounts.map((x) => x.toJson())),
    "payment_options": paymentOptions.toJson(),
    "delivery_options": deliveryOptions.toJson(),
  };
}

class DeliveryOptions {
  DeliveryOptions({
    this.delivery,
  });

  List<Delivery> delivery;

  factory DeliveryOptions.fromJson(Map<String, dynamic> json) => DeliveryOptions(
    delivery: List<Delivery>.from(json["delivery"].map((x) => Delivery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "delivery": List<dynamic>.from(delivery.map((x) => x.toJson())),
  };
}

class Delivery {
  Delivery({
    this.id,
    this.name,
    this.cost,
  });

  int id;
  String name;
  double cost;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    id: json["id"],
    name: json["name"],
    cost: json["cost"] is int ? double.parse(json["cost"].toString()) : json["cost"],
  );

  Map<String, dynamic> toJson() => {
    "delivery_id": id,
    "delivery_name": name,
    "delivery_fee": cost,
  };
}

class Discount {
  Discount({
    this.name,
    this.value,
  });

  String name;
  int value;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}

class PaymentOptions {
  PaymentOptions({
    this.gateway,
  });

  List<Gateway> gateway;

  factory PaymentOptions.fromJson(Map<String, dynamic> json) => PaymentOptions(
    gateway: List<Gateway>.from(json["gateway"].map((x) => Gateway.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gateway": List<dynamic>.from(gateway.map((x) => x.toJson())),
  };
}

class Gateway {
  Gateway({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

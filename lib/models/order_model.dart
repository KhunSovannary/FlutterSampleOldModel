class OrderModel {
  OrderModel({
    this.userName,
    this.id,
    this.shopName,
    this.shopLogo,
    this.userId,
    this.shopId,
    this.dateOrderPlaced,
    this.dateOrderPaid,
    this.orderStatusId,
    this.deliveryOptionId,
    this.addressFullName,
    this.addressEmail,
    this.addressPhone,
    this.addressStreetAddress,
    this.addressCityProvinceId,
    this.addressDistrictId,
    this.phonePickup,
    this.note,
    this.preferredDeliveryPickupDate,
    this.preferredDeliveryPickupTime,
    this.paymentMethodId,
    this.deliveryId,
    this.deliveryPickupDate,
    this.pickupLat,
    this.pickupLon,
    this.pointExchangeRate,
    this.total,
    this.totalUsePoints,
    this.createdAt,
    this.updatedAt,
    this.shopPhoneNumber,
  });

  String userName;
  int id;
  dynamic shopName;
  dynamic shopLogo;
  int userId;
  int shopId;
  String dateOrderPlaced;
  String dateOrderPaid;
  int orderStatusId;
  int deliveryOptionId;
  String addressFullName;
  String addressEmail;
  String addressPhone;
  String addressStreetAddress;
  int addressCityProvinceId;
  int addressDistrictId;
  String phonePickup;
  String note;
  String preferredDeliveryPickupDate;
  String preferredDeliveryPickupTime;
  int paymentMethodId;
  int deliveryId;
  String deliveryPickupDate;
  String pickupLat;
  String pickupLon;
  String pointExchangeRate;
  dynamic total;
  String totalUsePoints;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic shopPhoneNumber;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    userName: json["user_name"],
    id: json["id"],
    shopName: json["shop_name"],
    shopLogo: json["shop_logo"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    dateOrderPlaced: json["date_order_placed"],
    dateOrderPaid: json["date_order_paid"],
    orderStatusId: json["order_status_id"],
    deliveryOptionId: json["delivery_option_id"],
    addressFullName: json["address_full_name"],
    addressEmail: json["address_email"],
    addressPhone: json["address_phone"],
    addressStreetAddress: json["address_street_address"],
    addressCityProvinceId: json["address_city_province_id"],
    addressDistrictId: json["address_district_id"],
    phonePickup: json["phone_pickup"],
    note: json["note"],
    preferredDeliveryPickupDate:json["preferred_delivery_pickup_date"],
    preferredDeliveryPickupTime: json["preferred_delivery_pickup_time"],
    paymentMethodId: json["payment_method_id"],
    deliveryId: json["delivery_id"],
    deliveryPickupDate: json["delivery_pickup_date"],
    pickupLat: json["pickup_lat"],
    pickupLon: json["pickup_lon"],
    pointExchangeRate: json["point_exchange_rate"],
    total: json["total"] is String ? double.parse(json["total"]) : json["total"],
    totalUsePoints: json["total_use_points"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shopPhoneNumber: json["shop_phone_number"],
  );
}

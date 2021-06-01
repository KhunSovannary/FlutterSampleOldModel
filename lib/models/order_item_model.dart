class OrderItem {
  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.name,
    this.unitId,
    this.unitPrice,
    this.pointRate,
    this.quantity,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.imageName,
  });

  int id;
  int orderId;
  int productId;
  String name;
  int unitId;
  String unitPrice;
  String pointRate;
  int quantity;
  String discount;
  dynamic createdAt;
  dynamic updatedAt;
  String imageName;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    name: json["name"],
    unitId: json["unit_id"],
    unitPrice: json["unit_price"],
    pointRate: json["point_rate"].toString(),
    quantity: json["quantity"],
    discount: json["discount"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    imageName: json["image_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "name": name,
    "unit_id": unitId,
    "unit_price": unitPrice,
    "point_rate": pointRate,
    "quantity": quantity,
    "discount": discount,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_name": imageName,
  };
}
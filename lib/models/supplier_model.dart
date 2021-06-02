class SupplierModel {
  SupplierModel({
    this.id,
    this.name,
    this.membershipId,
    this.membershipName,
    this.shopCategoryName,
    this.city,
    this.district,
  });

  int id;
  String name;
  int membershipId;
  String membershipName;
  String shopCategoryName;
  String city;
  String district;

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
    id: json["id"],
    name: json["name"],
    membershipId: json["membership_id"],
    membershipName: json["membership_name"],
    shopCategoryName: json["shop_category_name"],
    city: json["city"],
    district: json["district"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "membership_id": membershipId,
    "membership_name": membershipName,
    "shop_category_name": shopCategoryName,
    "city": city,
    "district": district,
  };
}

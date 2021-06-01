class ShopModel {
  ShopModel({
    this.id,
    this.shopCategoryId,
    this.userId,
    this.supplierId,
    this.name,
    this.about,
    this.logoImage,
    this.coverImage,
    this.phone,
    this.countryId,
    this.cityProvinceId,
    this.districtId,
    this.address,
    this.lat,
    this.lng,
    this.membershipId,
    this.isActive,
    this.status,
    this.membershipName,
    this.shopCategoryName,
    this.city,
    this.district
  });

  int id;
  int shopCategoryId;
  int userId;
  int supplierId;
  String name;
  String about;
  String logoImage;
  String coverImage;
  String phone;
  int countryId;
  int cityProvinceId;
  int districtId;
  String address;
  String lat;
  String lng;
  int membershipId;
  int isActive;
  int status;
  String membershipName;
  String shopCategoryName;
  String city;
  String district;

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
    id: json["id"],
    shopCategoryId: json["shop_category_id"],
    userId: json["user_id"],
    supplierId: json["supplier_id"],
    name: json["name"],
    about: json["about"],
    logoImage: json["logo_image"],
    coverImage: json["cover_image"],
    phone: json["phone"],
    countryId: json["country_id"],
    cityProvinceId: json["city_province_id"],
    districtId: json["district_id"],
    address: json["address"],
    lat: json["lat"],
    lng: json["lng"],
    membershipId: json["membership_id"],
    isActive: json["is_active"],
    status: json["status"],
    membershipName: json["membership_name"],
    shopCategoryName: json["shop_category_name"],
    city: json['city'],
    district: json['district'],
  );

}

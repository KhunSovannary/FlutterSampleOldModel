
class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.unitPrice,
    this.salePrice,
    this.shopId,
    this.shopName,
    this.imageName,
    this.pointRate,
    this.flag,
    this.discount,
    this.brandId,
    this.brandName,
    this.categoryId,
    this.categoryName,
    this.unitId,
    this.unitName,
    this.description,
    this.images,
    this.options,
    this.variants,
    this.isPromoted,
    this.isActive,
  });

  int id;
  String name;
  String unitPrice;
  String salePrice;
  int shopId;
  String shopName;
  String imageName;
  int pointRate;
  int flag;
  int discount;
  int brandId;
  String brandName;
  dynamic categoryId;
  String categoryName;
  int unitId;
  String unitName;
  String description;
  List<ProductImage> images;
  List<Option> options;
  List<dynamic> variants;
  int isPromoted;
  int isActive;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    unitPrice: json["unit_price"],
    salePrice: json["sale_price"],
    shopId: json["shop_id"],
    shopName: json["shop_name"],
    imageName: json["image_name"],
    pointRate: json["point_rate"],
    flag: json["flag"],
    discount: json["discount"],
    brandId: json["brand_id"],
    brandName: json["brand_name"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    unitId: json["unit_id"],
    unitName: json["unit_name"],
    description: json["description"],
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    options: json["options"] == null ? [] : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
//    variants: List<dynamic>.from(json["variants"].map((x) => x)),
    isPromoted: json["is_promoted"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unit_price": unitPrice,
    "sale_price": salePrice,
    "shop_id": shopId,
    "shop_name": shopName,
    "image_name": imageName,
    "point_rate": pointRate,
    "flag": flag,
    "discount": discount,
    "brand_id": brandId,
    "brand_name": brandName,
    "category_id": categoryId,
    "category_name": categoryName,
    "unit_id": unitId,
    "unit_name": unitName,
    "description": description,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "variants": List<dynamic>.from(variants.map((x) => x)),
    "is_promoted": isPromoted,
    "is_active": isActive,
  };
}

class ProductImage {
  ProductImage({
    this.imageName,
  });

  String imageName;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    imageName: json["image_name"],
  );
}

class Option {
  Option({
    this.id,
    this.name,
    this.values,
  });

  int id;
  String name;
  List<Value> values;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    name: json["name"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    this.id,
    this.name,
    this.imageName,
  });

  int id;
  String name;
  String imageName;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    name: json["name"],
    imageName: json["image_name"] == null ? null : json["image_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image_name": imageName == null ? null : imageName,
  };
}

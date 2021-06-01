class BrandModel {
  BrandModel({
    this.id,
    this.name,
    this.slug,
    this.imageName,
    this.order,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String slug;
  String imageName;
  int order;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    imageName: json["image_name"],
    order: json["order"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
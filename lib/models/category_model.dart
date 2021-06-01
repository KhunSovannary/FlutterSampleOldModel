class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.imageName,
  });

  int id;
  int parentId;
  String name;
  String imageName;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["default_name"],
    imageName: json["image_name"],
  );
}
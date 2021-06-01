class QueryModel {
  QueryModel({
    this.id,
    this.name,
    this.brandName,
    this.categoryName,
    this.unitName,
  });

  int id;
  String name;
  String brandName;
  String categoryName;
  String unitName;

  factory QueryModel.fromJson(Map<String, dynamic> json) => QueryModel(
    id: json["id"],
    name: json["name"],
  );
}
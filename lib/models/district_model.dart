class DistrictModel {
  DistrictModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    id: json["id"],
    name: json["default_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "default_name": name,
  };
}

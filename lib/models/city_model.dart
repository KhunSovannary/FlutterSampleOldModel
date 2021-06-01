class CityModel {
  CityModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    name: json["default_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "default_name": name,
  };
}

class DistrictModel {
  DistrictModel({
    this.id,
    this.defaultName,
  });

  int id;
  String defaultName;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    id: json["id"],
    defaultName: json["default_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "default_name": defaultName,
  };
}

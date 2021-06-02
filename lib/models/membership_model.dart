class MembershipModel {
  MembershipModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory MembershipModel.fromJson(Map<String, dynamic> json) => MembershipModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

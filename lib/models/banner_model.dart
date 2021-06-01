class BannerModel {
  BannerModel({
    this.id,
    this.title,
    this.image,
    this.targetUrl,
  });

  int id;
  String title;
  String image;
  String targetUrl;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    targetUrl: json["target_url"],
  );
}
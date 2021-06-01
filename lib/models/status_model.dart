class StatusModel {
  StatusModel({
    this.all,
    this.processing,
    this.pending,
    this.dilivery,
    this.completed,
    this.cancelled,
  });

  int all;
  int processing;
  int pending;
  int dilivery;
  int completed;
  int cancelled;

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
    all: json["all"],
    processing: json["processing"],
    pending: json["pending"],
    dilivery: json["dilivery"],
    completed: json["completed"],
    cancelled: json["cancelled"],
  );
}
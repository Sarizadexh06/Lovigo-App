class WorkoutHabits {
  WorkoutHabits({
    required this.data,
  });

  final List<Datum> data;

  factory WorkoutHabits.fromJson(Map<String, dynamic> json) {
    return WorkoutHabits(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.status,
  });

  final int? id;
  final String? name;
  final dynamic status;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      status: json["status"],
    );
  }
}

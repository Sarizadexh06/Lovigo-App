class DrinkingHabits {
  final int id;
  final String name;

  DrinkingHabits({required this.id, required this.name});

  factory DrinkingHabits.fromJson(Map<String, dynamic> json) {
    return DrinkingHabits(
      id: json['id'],
      name: json['name'],
    );
  }
}


class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.status,
  });

  final int? id;
  final String? name;
  final dynamic status;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      status: json["status"],
    );
  }

}

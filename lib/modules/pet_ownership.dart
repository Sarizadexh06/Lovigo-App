class PetOwnership {
  final int id;
  final String name;

  PetOwnership({required this.id, required this.name});

  factory PetOwnership.fromJson(Map<String, dynamic> json) {
    return PetOwnership(
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

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      status: json["status"],
    );
  }
}

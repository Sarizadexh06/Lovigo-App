class Zodiac {
  Zodiac({
    required this.data,
  });

  final List<Datum> data;

  factory Zodiac.fromJson(Map<String, dynamic> json){
    return Zodiac(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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
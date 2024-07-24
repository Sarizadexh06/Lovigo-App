class Gender {
  final int id;
  final String name;
  final String? status;

  Gender({required this.id, required this.name, this.status});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

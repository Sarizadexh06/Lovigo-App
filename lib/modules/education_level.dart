class EducationLevel {
  final int id;
  final String name;
  final String? status;

  EducationLevel({required this.id, required this.name, this.status});

  factory EducationLevel.fromJson(Map<String, dynamic> json) {
    return EducationLevel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

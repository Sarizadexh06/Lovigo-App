class DietaryPreference {
  final int id;
  final String name;
  final String? status;

  DietaryPreference({required this.id, required this.name, this.status});

  factory DietaryPreference.fromJson(Map<String, dynamic> json) {
    return DietaryPreference(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

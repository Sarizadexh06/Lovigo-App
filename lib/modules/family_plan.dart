class FamilyPlan {
  final int id;
  final String name;
  final String? status;

  FamilyPlan({required this.id, required this.name, this.status});

  factory FamilyPlan.fromJson(Map<String, dynamic> json) {
    return FamilyPlan(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

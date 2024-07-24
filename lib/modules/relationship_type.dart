class RelationshipType {
  final int id;
  final String name;
  final String? status;

  RelationshipType({required this.id, required this.name, this.status});

  factory RelationshipType.fromJson(Map<String, dynamic> json) {
    return RelationshipType(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

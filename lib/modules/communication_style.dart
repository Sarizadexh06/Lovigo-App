class CommunicationStyle {
  final int id;
  final String name;
  final String? status;

  CommunicationStyle({required this.id, required this.name, this.status});

  factory CommunicationStyle.fromJson(Map<String, dynamic> json) {
    return CommunicationStyle(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

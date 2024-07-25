class SocialMediaUse {
  final int id;
  final String name;
  final String? status;

  SocialMediaUse({required this.id, required this.name, this.status});

  factory SocialMediaUse.fromJson(Map<String, dynamic> json) {
    return SocialMediaUse(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

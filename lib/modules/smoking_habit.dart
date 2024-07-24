class SmokingHabit {
  final int id;
  final String name;
  final String? status;

  SmokingHabit({required this.id, required this.name, this.status});

  factory SmokingHabit.fromJson(Map<String, dynamic> json) {
    return SmokingHabit(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

class SleepingRoutine {
  final int id;
  final String name;
  final String? status;

  SleepingRoutine({required this.id, required this.name, this.status});

  factory SleepingRoutine.fromJson(Map<String, dynamic> json) {
    return SleepingRoutine(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

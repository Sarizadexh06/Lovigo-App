class UserInfo {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  int? genderId;
  int? relationshipTypeId;
  int? smokingHabitId;
  int? drinkingHabitId;
  int? workoutHabitId;
  int? petOwnershipId;

  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    this.genderId,
    this.relationshipTypeId,
    this.smokingHabitId,
    this.drinkingHabitId,
    this.workoutHabitId,
    this.petOwnershipId,
  });
}

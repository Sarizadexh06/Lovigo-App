class UserInfo {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  int genderId;
  int relationshipTypeId;
  int smokingHabitId;
  int drinkingHabitId;
  int workoutHabitId;
  int petOwnershipId;
  int zodiacId;
  int socialMediaUseId;
  int educationId;
  int dietaryPreferenceId;
  int sleepingRoutineId;
  int familyPlanId;
  int communicationStyleId;

  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.genderId,
    required this.relationshipTypeId,
    required this.smokingHabitId,
    required this.drinkingHabitId,
    required this.workoutHabitId,
    required this.petOwnershipId,
    required this.zodiacId,
    required this.socialMediaUseId,
    required this.educationId,
    required this.dietaryPreferenceId,
    required this.sleepingRoutineId,
    required this.familyPlanId,
    required this.communicationStyleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'gender_id': genderId,
      'relationship_type_id': relationshipTypeId,
      'smoking_habit_id': smokingHabitId,
      'drinking_habit_id': drinkingHabitId,
      'workout_routine_id': workoutHabitId,
      'pet_ownership_id': petOwnershipId,
      'zodiac_id': zodiacId,
      'social_media_usage_id': socialMediaUseId,
      'education_level_id': educationId,
      'dietary_preferance_id': dietaryPreferenceId,
      'sleeping_routine_id': sleepingRoutineId,
      'family_plan_id': familyPlanId,
      'communication_style_id': communicationStyleId,
    };
  }
}

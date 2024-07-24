import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://lovigo.net/user';

  Future<int> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required int genderId,
    required int relationshipTypeId,
    required int smokingHabitId,
    required int drinkingHabitId,
    required int workoutHabitId,
    required int petOwnershipId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone': phone,
          'password': password,
          'gender_id': genderId,
          'relationship_type_id': relationshipTypeId,
          'smoking_habit_id': smokingHabitId,
          'drinking_habit_id': drinkingHabitId,
          'workout_habit_id': workoutHabitId,
          'pet_ownership_id': petOwnershipId,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data']['id'];
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to create user: $e');
    }
  }
}

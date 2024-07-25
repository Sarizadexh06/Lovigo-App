import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://lovigo.net/user';

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
    required int zodiacId,
    required int socialMediaUseId,
    required int educationId,
    required int dietaryPreferenceId,
    required int sleepingRoutineId,
    required int familyPlanId,
    required int communicationStyleId,
  }) async {
    try {
      final body = jsonEncode({
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
        'zodiac_id': zodiacId,
        'social_media_use_id': socialMediaUseId,
        'education_id': educationId,
        'dietary_preference_id': dietaryPreferenceId,
        'sleeping_routine_id': sleepingRoutineId,
        'family_plan_id': familyPlanId,
        'communication_style_id': communicationStyleId,
      });

      print('Request Body: $body');

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data']['id'];
      } else if (response.statusCode == 302) {

        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {

          final redirectedResponse = await http.post(
            Uri.parse(redirectUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: body,
          );

          print('Redirected Response Status: ${redirectedResponse.statusCode}');
          print('Redirected Response Body: ${redirectedResponse.body}');

          if (redirectedResponse.statusCode == 201 || redirectedResponse.statusCode == 200) {
            final responseData = jsonDecode(redirectedResponse.body);
            return responseData['data']['id'];
          } else {
            throw Exception('Failed to create user after redirect');
          }
        } else {
          throw Exception('No redirect URL found');
        }
      } else {
        print('Failed Response: ${response.body}');
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to create user: $e');
    }
  }
}

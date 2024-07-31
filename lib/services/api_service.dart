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
        'workout_routine_id': workoutHabitId,
        'pet_ownership_id': petOwnershipId,
        'zodiac_id': zodiacId,
        'social_media_usage_id': socialMediaUseId,
        'education_level_id': educationId,
        'dietary_preference_id': dietaryPreferenceId,
        'sleeping_routine_id': sleepingRoutineId,
        'family_plan_id': familyPlanId,
        'communication_style_id': communicationStyleId,
      });

      print('Request Body: $body');

      var response = await http.post(
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
        final userId = responseData['data']['id'];
        if (userId != null) {
          return userId;
        } else {
          throw Exception('User ID not found in the response');
        }
      } else if (response.statusCode == 302) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null && redirectUrl.isNotEmpty) {
          final validUrl = Uri.parse(redirectUrl);
          if (validUrl.isAbsolute) {
            response = await http.post(
              validUrl,
              headers: {
                'Content-Type': 'application/json',
              },
              body: body,
            );

            print('Redirected Response Status: ${response.statusCode}');
            print('Redirected Response Body: ${response.body}');

            if (response.statusCode == 201 || response.statusCode == 200) {
              final responseData = jsonDecode(response.body);
              final userId = responseData['data']['id'];
              if (userId != null) {
                return userId;
              } else {
                throw Exception('User ID not found in the redirected response');
              }
            } else {
              throw Exception('Failed to create user after redirect. Status: ${response.statusCode}, Body: ${response.body}');
            }
          } else {
            throw Exception('Invalid redirect URL: $redirectUrl');
          }
        } else {
          throw Exception('No redirect URL found');
        }
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found: ${response.request?.url}');
      } else {
        print('Failed Response: ${response.body}');
        throw Exception('Failed to create user. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to create user: $e');
    }
  }
}

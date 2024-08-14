import 'package:http/http.dart' as http;
import 'package:lovigoapp/modules/communication_style.dart';
import 'package:lovigoapp/modules/drinking_habit.dart';
import 'dart:convert';
import 'package:lovigoapp/modules/education_level.dart';
import 'package:lovigoapp/modules/family_plan.dart';
import 'package:lovigoapp/modules/gender_module.dart';
import 'package:lovigoapp/modules/pet_ownership.dart';
import 'package:lovigoapp/modules/relationship_type.dart';
import 'package:lovigoapp/modules/smoking_habit.dart';
import 'package:lovigoapp/modules/zodiac_module.dart';

class UserService {
  Future<List<Gender>> fetchGenders() async {
    final response = await http.get(Uri.parse('https://lovigo.net/genders'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((gender) => Gender.fromJson(gender)).toList();
    } else {
      throw Exception('Failed to load genders');
    }
  }

  Future<List<RelationshipType>> fetchRelationshipTypes() async {
    final response = await http.get(Uri.parse('https://lovigo.net/relationship-types'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((type) => RelationshipType.fromJson(type)).toList();
    } else {
      throw Exception('Failed to load relationship types');
    }
  }

  Future<List<Zodiac>> fetchZodiacs() async {
    final response = await http.get(Uri.parse('http://lovigo.net/zodiacs'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse.map((zodiac) => Zodiac.fromJson(zodiac)).toList();
    } else {
      throw Exception('Failed to load zodiacs');
    }
  }

  Future<List<EducationLevel>> fetchEducationLevels() async {
    final response = await http.get(Uri.parse('http://lovigo.net/education-levels'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((educationLevel) => EducationLevel.fromJson(educationLevel)).toList();
    } else {
      throw Exception('Failed to load education levels');
    }
  }

  Future<List<FamilyPlan>> fetchFamilyPlans() async {
    final response = await http.get(Uri.parse('http://lovigo.net/family-plans'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((familyPlans) => FamilyPlan.fromJson(familyPlans)).toList();
    } else {
      throw Exception('Failed to load family plans');
    }
  }
  Future<List<CommunicationStyle>> fetchCommunicationStyles() async {
    final response = await http.get(Uri.parse('http://lovigo.net/communication-styles'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((communicationStyle) => CommunicationStyle.fromJson(communicationStyle)).toList();
    } else {
      throw Exception('Failed to load communication styles');
    }
  }
  Future<List<PetOwnership>> fetchPetOwnerships() async {
    final response = await http.get(Uri.parse('http://lovigo.net/pet-ownerships'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((petOwnership) => PetOwnership.fromJson(petOwnership)).toList();
    } else {
      throw Exception('Failed to load pet ownerships');
    }
  }

  Future<List<DrinkingHabits>> fetchDrinkingHabits() async {
    final response = await http.get(Uri.parse('http://lovigo.net/drinking-habits'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((drinkingHabit) => DrinkingHabits.fromJson(drinkingHabit)).toList();
    } else {
      throw Exception('Failed to load drinking habits');
    }
  }
  Future<List<SmokingHabit>> fetchSmokingHabits() async {
    final response = await http.get(Uri.parse('http://lovigo.net/smoking-habits'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((smokingHabit) => SmokingHabit.fromJson(smokingHabit)).toList();
    } else {
      throw Exception('Failed to load smoking habits');
    }
  }

}

import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  int? _selectedSmokingIndex;
  int? _selectedDrinkingIndex;
  int? _selectedWorkoutIndex;
  int? _selectedPetIndex;
  int? _selectedZodiacIndex;
  int? _selectedSocialMediaUseIndex;
  int? _selectedEducationIndex;
  int? _selectedDietaryPreferenceIndex;
  int? _selectedSleepingRoutineIndex;
  int? _selectedFamilyPlanIndex;
  int? _selectedCommunicationStyleIndex;

  int? get selectedSmokingIndex => _selectedSmokingIndex;
  int? get selectedDrinkingIndex => _selectedDrinkingIndex;
  int? get selectedWorkoutIndex => _selectedWorkoutIndex;
  int? get selectedPetIndex => _selectedPetIndex;
  int? get selectedZodiacIndex => _selectedZodiacIndex;
  int? get selectedSocialMediaUseIndex => _selectedSocialMediaUseIndex;
  int? get selectedEducationIndex => _selectedEducationIndex;
  int? get selectedDietaryPreferenceIndex => _selectedDietaryPreferenceIndex;
  int? get selectedSleepingRoutineIndex => _selectedSleepingRoutineIndex;
  int? get selectedFamilyPlanIndex => _selectedFamilyPlanIndex;
  int? get selectedCommunicationStyleIndex => _selectedCommunicationStyleIndex;

  void selectSmokingIndex(int index) {
    _selectedSmokingIndex = index;
    notifyListeners();
  }

  void selectDrinkingIndex(int index) {
    _selectedDrinkingIndex = index;
    notifyListeners();
  }

  void selectWorkoutIndex(int index) {
    _selectedWorkoutIndex = index;
    notifyListeners();
  }

  void selectPetIndex(int index) {
    _selectedPetIndex = index;
    notifyListeners();
  }

  void selectZodiacIndex(int index) {
    _selectedZodiacIndex = index;
    notifyListeners();
  }

  void selectSocialMediaUse(int index) {
    _selectedSocialMediaUseIndex = index;
    notifyListeners();
  }

  void selectEducationIndex(int index) {
    _selectedEducationIndex = index;
    notifyListeners();
  }

  void selectDietaryPreferenceIndex(int index) {
    _selectedDietaryPreferenceIndex = index;
    notifyListeners();
  }

  void selectSleepingRoutineIndex(int index) {
    _selectedSleepingRoutineIndex = index;
    notifyListeners();
  }

  void selectFamilyPlanIndex(int index) {
    _selectedFamilyPlanIndex = index;
    notifyListeners();
  }

  void selectCommunicationStyleIndex(int index) {
    _selectedCommunicationStyleIndex = index;
    notifyListeners();
  }
}

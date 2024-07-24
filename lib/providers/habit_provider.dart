import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  int? _selectedSmokingIndex;
  int? _selectedDrinkingIndex;
  int? _selectedWorkoutIndex;
  int? _selectedPetIndex;
  int? _selectedZodiacIndex;
  int? _selectedSocialMediaUseIndex;

  int? get selectedSmokingIndex => _selectedSmokingIndex;
  int? get selectedDrinkingIndex => _selectedDrinkingIndex;
  int? get selectedWorkoutIndex => _selectedWorkoutIndex;
  int? get selectedPetIndex => _selectedPetIndex;
  int? get selectedZodiacIndex => _selectedZodiacIndex;
  int? get selectedSocialMediaUseIndex => _selectedSocialMediaUseIndex;

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
}

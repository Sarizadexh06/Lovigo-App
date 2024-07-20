import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  int? _selectedSmokingIndex;
  int? _selectedDrinkingIndex;
  int? _selectedWorkoutIndex;
  int? _selectedPetIndex;
  int? _selectedZodiacIndex; // Changed to match naming convention

  int? get selectedSmokingIndex => _selectedSmokingIndex;
  int? get selectedDrinkingIndex => _selectedDrinkingIndex;
  int? get selectedWorkoutIndex => _selectedWorkoutIndex;
  int? get selectedPetIndex => _selectedPetIndex;
  int? get selectedZodiacIndex => _selectedZodiacIndex; // Changed getter name

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
}

import 'package:flutter/material.dart';

import '../data/models/models.dart';

class PlantProvider with ChangeNotifier {
  final List<Plant> _plants = [];

  List<Plant> get plants => List.unmodifiable(_plants);

  void addPlant(Plant plant) {
    _plants.add(plant);
    notifyListeners();
  }

  void updatePlant(Plant updatedPlant) {
    final index = _plants.indexWhere((p) => p.id == updatedPlant.id);
    if (index != -1) {
      _plants[index] = updatedPlant;
      notifyListeners();
    }
  }
}

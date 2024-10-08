import 'package:flutter/foundation.dart';
import 'package:account/models/plants.dart';
import 'package:account/databases/plant_db.dart';

class PlantProvider with ChangeNotifier {
  List<Plant> plants = [];

  List<Plant> getPlants() {
    return plants;
  }

  Future<void> initData() async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      plants = await db.loadAllPlants();
      notifyListeners();
    } catch (e) {
      print("Error loading plants: $e");
    }
  }

  Future<void> addPlant(Plant plant) async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      await db.insertPlant(plant);
      await initData(); // Refresh data
    } catch (e) {
      print("Error adding plant: $e");
    }
  }

  Future<void> deletePlant(int? id) async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      await db.deletePlant(id);
      await initData(); // Refresh data
    } catch (e) {
      print("Error deleting plant: $e");
    }
  }

  Future<Plant?> getPlantById(int id) async {
    var db = PlantDB(dbName: 'plants.db');
    return await db.getPlantById(id);
  }

  Future<void> updatePlant(Plant plant) async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      await db.updatePlant(plant);
      plants = await db.loadAllPlants();
      notifyListeners();
    } catch (e) {
      print("Error updating plant: $e");
    }
  }
}

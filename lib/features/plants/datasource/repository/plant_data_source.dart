
import '../models/plant.dart';

abstract class PlantDataSource {
  
Future<List<Plant>> fetchAllplant();
Future<Plant?> fecthPlantById(int id);
Future<void> insertPlant(Plant plant);
Future<void> updatePlant(Plant plant);
Future<void> deletePlant(int it);
}
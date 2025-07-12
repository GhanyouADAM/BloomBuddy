
import '../../datasource/models/plant.dart';

abstract class PlantRepository {
  

Future<List<Plant>> getAllPlants();
Future<Plant?> getPlantById(int id);
Future<void> savePlant(Plant plantToSave);
Future<void> updatePlant(Plant plantToUpdate);
Future<void> deletePlant(int id);
}
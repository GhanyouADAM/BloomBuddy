
// ignore_for_file: avoid_print

import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/repository/plant_data_source.dart';
import 'package:definitive_bloom_buddy/features/plants/domain/repository/plant_repository.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantDataSource _source;

  PlantRepositoryImpl(this._source);

  @override
  Future<void> deletePlant(int id) async{
    try {
      await _source.deletePlant(id);
    } catch (e) {
      print("Error from repository while deleting plant : $e");
      rethrow;
    }
  }

  @override
  Future<List<Plant>> getAllPlants() async{
   try {
     return await _source.fetchAllplant();
   } catch (e) {
     print("Error from repository while fetching all plants from database : $e");
     rethrow;
   }
  }

  @override
  Future<Plant?> getPlantById(int id) async{
    try {
      return  await _source.fecthPlantById(id);
    } catch (e) {
      print("Error while retriving plant : $e");
      rethrow;
    }
  }

  @override
  Future<void> savePlant(Plant plantToSave) async{
    try {
      await _source.insertPlant(plantToSave);
    } catch (e) {
      print("Error from repository while adding plant : $e");
      rethrow;
    }
  }

  @override
  Future<void> updatePlant(Plant plantToUpdate) async {
    try {
      await _source.updatePlant(plantToUpdate);
    } catch (e) {
      print("Error from repository while adding plant : $e");
      rethrow;
    }
  }
  
}
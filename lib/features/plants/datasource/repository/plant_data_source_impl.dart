
// ignore_for_file: avoid_print

import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/repository/plant_data_source.dart';
import 'package:isar/isar.dart';

class PlantDataSourceImpl implements PlantDataSource {
  final Isar isar; //instance Isar

  PlantDataSourceImpl(this.isar);

//suprime une plante
  @override
  Future<void> deletePlant(int id) async{
    await isar.writeTxn(() => isar.plants.delete(id));
  }

//retourne une plante spécifique a partir de son id
  @override
  Future<Plant?> fecthPlantById(int id) async{
    final plant = await isar.writeTxn(() => isar.plants.get(id));
    if (plant != null) {
      print('found one plant of id ${plant.plantId}');
      return plant;
    }else{
      return null;
    }
  }

// retourne une liste de plante
  @override
  Future<List<Plant>> fetchAllplant() async{
    final plants = await isar.writeTxn(()=> isar.plants.where().findAll());
    if (plants.isNotEmpty) {
      print('found ${plants.length} plants');
      return plants;
    }else{
      print('no plants found in database');
      return [];
    }
  }

//ajoute une plante dans la base
  @override
  Future<void> insertPlant(Plant plant) async {
    await isar.writeTxn(() => isar.plants.put(plant));
  }

//Met a jour une plante dans la base
  @override
  Future<void> updatePlant(Plant plant) async{
    await isar.writeTxn(() => isar.plants.put(plant));
  }
  
}
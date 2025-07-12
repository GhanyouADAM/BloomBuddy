
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:definitive_bloom_buddy/core/providers/isar_provider.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/care_records/presentation/state/care_countdown_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/repository/plant_data_source.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/repository/plant_data_source_impl.dart';
import 'package:definitive_bloom_buddy/features/plants/domain/repository/plant_repository.dart';
import 'package:definitive_bloom_buddy/features/plants/domain/usescases/plant_repository_impl.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final plantDataSourceProvider = Provider<PlantDataSource>((ref){
  final isar = ref.watch(isarProvider).value;
  if (isar == null) {
    throw Exception('Isar instance  not availabale yet');
  }
  return PlantDataSourceImpl(isar);
});

final plantRepositoryProvider =  Provider<PlantRepository>((ref){
  final dataSource = ref.watch(plantDataSourceProvider);

  return PlantRepositoryImpl(dataSource);
});

class PlantNotifier extends AsyncNotifier<List<Plant>> {


  Future<List<Plant>>_fetchPlants() async {
    final plantRep = ref.watch(plantRepositoryProvider);
    try {
      final fetchedPlants = await plantRep.getAllPlants();
      return fetchedPlants;
    } catch (e, stackTrace) {
      print('Error fetching plant in Notifer ; $e\n$stackTrace');
      throw Exception('Error : $e');
    }
  }
   Future<List<Plant>>_fetchCareNeededPlants(List<Plant> plants) async {
    List<Plant> urgentPlants = [];

    try {
      for (final plant in plants) {
        //attends que le compteur soit disponible
        final countDownState = await ref.read(careCountdownProvider(plant.plantId).future);
        bool isUrgent = false;
        for (final entry in countDownState.entries) {
          final daysRemaining = entry.value;
          if (daysRemaining != null && daysRemaining <= 0) {
            isUrgent = true;
            break;
          }
        }
        if (isUrgent) {
          urgentPlants.add(plant);
        }
      }
      return urgentPlants;
    } catch (e, stackTrace) {
      print('Erreur au moment du filtrage de plantes: $e\n$stackTrace');
    throw Exception('Error: $e');
    }
    // print('debut du filtrage des plantes urgentes ${plants.length} au total');
    // List<Plant> urgentPlants = [];
    // try {     
    //   for (final plant in plants) {
    //     final countDownState = ref.read(careCountdownProvider(plant.plantId));
    //     if (countDownState.hasValue) {
    //      Map<Caretype, int?>? daysMap = countDownState.value;
    //      if (daysMap != null) {
    //       bool isUrgent =false;
    //        for (final entry in daysMap.entries) {
    //          final daysRemaining = entry.value;
    //          if (daysRemaining !=null && daysRemaining <= 0) {
    //            isUrgent =true;
    //            print('plante urgente trouvé !');
    //            break;
    //          }
    //        }
    //        if (isUrgent) {
    //          urgentPlants.add(plant);
    //        }
    //      }
    //     }
    //     }
    //         print('fin du filtrage ${urgentPlants.length} plantes trouvées');
    //     return urgentPlants;
    
    //   }
    //  catch (e, stackTrace) {
    //   print('Erreur au moment du filtrage de plantes ; $e\n$stackTrace');
    //   throw Exception('Error : $e');
    // }
  }
  @override
  FutureOr<List<Plant>> build() async{
    final currentFilter = ref.watch(plantFilterProvider);
    final currentQuery = ref.watch(searchQueryProvider).toLowerCase();
    try {
      List<Plant> filteredPlants = [];
      final plants = await _fetchPlants();
      switch (currentFilter) {
        case PlantFilter.urgent:
          filteredPlants = await _fetchCareNeededPlants(plants);
        case PlantFilter.favorites:
        filteredPlants = await _fetchFavoritesPlants(plants);
        case PlantFilter.plants :
         filteredPlants = plants;
        break;
      }
      if (currentQuery == '') {
        return filteredPlants;
      }else {
        filteredPlants = filteredPlants.where((plant)=>plant.plantName.toLowerCase().contains(currentQuery)).toList();
        return filteredPlants;
      }
    } catch (error) {
      print('Error loading plant in Notifer ; $error');
      rethrow;
    }
  }

  Future<void> deletePlant(int id) async {
    final plantRep = ref.read(plantRepositoryProvider);
    final previousState = state; // Keep the previous state for potential rollback

    // --- Optimistic Update ---
    // 1. Check if we currently have data
    if (state is AsyncData<List<Plant>>) {
       final currentPlant = state.value!; // Get the current list
       // 2. Create the NEW list without the deleted task
       final updatedPlant = currentPlant.where((plant) => plant.plantId != id).toList();
       // 3. Update the state SYNCHRONOUSLY
       state = AsyncData(updatedPlant);
       print("Optimistically removed plant $id. State updated.");
    } else {
       // If state is loading or error, maybe don't allow deletion
       // or handle differently. For now, we just proceed to delete from DB.
       print("State was not AsyncData during delete, proceeding with DB delete only.");
    }
    try {
      await plantRep.deletePlant(id);
      ref.invalidateSelf();
    } catch (e) {
      print(e);
      state = previousState;
    }
  }

  Future<List<CareRecord>> getCareRecordByPlant(int plantId) async{
    final plantRep = ref.read(plantRepositoryProvider);
    try {
     final plant =  await plantRep.getPlantById(plantId);
     if (plant != null) {
       await plant.careHistory.load();
       return plant.careHistory.toList();
     }else{
      return [];
     }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> savePlant(Plant plant) async {
    final plantRep = ref.read(plantRepositoryProvider);
    try {
      await plantRep.savePlant(plant);
      ref.invalidateSelf();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePlant(Plant plant) async {
    final plantRep = ref.read(plantRepositoryProvider);
    try {
      await plantRep.updatePlant(plant);
      ref.invalidateSelf();
    } catch (e) {
      print(e);
    }
  }
  
  Future<Plant?> getPlantById(int id) async {
    final plantRep = ref.read(plantRepositoryProvider);
    try {
      final plant = await plantRep.getPlantById(id);
      if (plant != null) {
        return plant;
      }else{
        return null;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<List<Plant>> _fetchFavoritesPlants(List<Plant> plants) async {
    List<Plant> favoritePlants = [];
    favoritePlants = plants.where((plant)=> plant.isFavorite == true).toList();
    return favoritePlants;
  } 
  Future<void> refreshData() async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    final currentFilter = ref.read(plantFilterProvider);
    final plants = await _fetchPlants();
    
    switch (currentFilter) {
      case PlantFilter.urgent:
        return await _fetchCareNeededPlants(plants);
      case PlantFilter.plants:
      default:
        return plants;
    }
  });
}
}

final plantNotifierProvider = AsyncNotifierProvider<PlantNotifier, List<Plant>>((){
  return PlantNotifier();
});
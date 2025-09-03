import 'package:bloom_buddy/src/features/plants/view/providers/plant_filter_provider.dart';

import '../entities/plant.dart';

abstract class PlantRepository {
  Stream<List<Plant>> watchPlants(
    String userId,
    PlantFilter filter, {
    String? searchQuery,
  });
  Stream<List<Plant>> watchLikePlants(String userId);
  Future<void> createPlant(
    String plantName,
    String plantSpecie,
    String? plantDescription,
  );
  Future<void> updatePlant(Plant plant);
  Future<void> deletePlant(String plantId);
}

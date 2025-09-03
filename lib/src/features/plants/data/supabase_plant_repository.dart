import 'package:bloom_buddy/src/features/plants/view/providers/plant_filter_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/entities/plant.dart';
import '../domain/repositories/plant_repository.dart';

class SupabasePlantRepository implements PlantRepository {
  final SupabaseClient _client;
  SupabasePlantRepository(this._client);

  @override
  Stream<List<Plant>> watchPlants(
    String userId,
    PlantFilter filter, {
    String? searchQuery,
  }) {
    String queryFilter = 'created_at';
    switch (filter) {
      case PlantFilter.date:
        queryFilter = "created_at";
        break;
      case PlantFilter.name:
        queryFilter = "plant_name";
        break;
      case PlantFilter.category:
        queryFilter = "plant_specie";
        break;
    }
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Utilisateur non disponible');
    final stream = _client
        .from('plants')
        .stream(primaryKey: ['plant_id'])
        .eq('user_id', userId)
        .order(
          queryFilter,
          ascending: queryFilter == 'created_at' ? false : true,
        );
    final activeQuery = (searchQuery != null && searchQuery.trim().isNotEmpty);
    return !activeQuery
        ? stream.map(
            (maps) => maps.map((map) => PlantMapper.fromMap(map)).toList(),
          )
        : stream.map(
            (maps) => maps
                .map((map) => PlantMapper.fromMap(map))
                .toList()
                .where(
                  (test) => test.plantName.toLowerCase().contains(searchQuery),
                )
                .toList(),
          );

    // String queryFilter = 'created_at';
    // switch (filter) {
    //   case PlantFilter.date:
    //     queryFilter = "created_at";
    //     break;
    //   case PlantFilter.name:
    //     queryFilter = "plant_name";
    //     break;
    //   case PlantFilter.category:
    //     queryFilter = "plant_specie";
    //     break;
    // }
    // final user = _client.auth.currentUser;
    // if (user == null) throw Exception('Utilisateur non disponible');
    // final query = _client.from('plants').select().eq("user_id", userId);
    // if (searchQuery != null && searchQuery.trim().isNotEmpty) {
    //   final searchPattern = '%${searchQuery.trim()}%';
    //   query.or(
    //     'plants_name.ilike.$searchPattern, plants_specie.ilike.$searchPattern ',
    //   );
    // }

    // return query
    //     .order(
    //       queryFilter,
    //       ascending: queryFilter == "created_at" ? false : true,
    //     )
    //     .asStream()
    //     .map((maps) => maps.map((map) => PlantMapper.fromMap(map)).toList());
  }

  @override
  Future<void> createPlant(
    String plantName,
    String plantSpecie,
    String? plantDescription,
  ) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('Utilisateur non disponible');
      await _client.from('plants').insert({
        "user_id": user.id,
        "plant_name": plantName,
        "plant_specie": plantSpecie,
        "plant_description": plantDescription,
      });
    } on PostgrestException catch (e) {
      throw Exception('Erreur lors de la création: ${e.message}');
    }
  }

  @override
  Future<void> deletePlant(String plantId) async {
    if (plantId.isEmpty) throw ArgumentError('ID plante requis');
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Utilisateur non disponible');
    await _client
        .from('plants')
        .delete()
        .eq('plant_id', plantId)
        .eq('user_id', user.id);
  }

  @override
  Future<void> updatePlant(Plant plant) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Utilisateur non disponible');
    await _client
        .from('plants')
        .update(plant.toMap())
        .eq('plant_id', plant.plantId)
        .eq('user_id', user.id);
  }

  @override
  Stream<List<Plant>> watchLikePlants(String userId) {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Utilisateur non disponible');
    final plantsStream = _client
        .from('plants')
        .stream(primaryKey: ['plant_id'])
        .eq('user_id', user.id)
        .map((maps) => maps.map((map) => PlantMapper.fromMap(map)).toList());
    return plantsStream.map(
      (plants) => plants.where((plant) => plant.isLiked).toList(),
    );
  }
}

import 'package:bloom_buddy/src/features/care_records/domain/entities/care_record.dart';
import 'package:bloom_buddy/src/features/care_records/domain/entities/care_requirements.dart';
import 'package:bloom_buddy/src/features/care_records/domain/repositories/care_requirements_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCareRequirementsRepsoitory implements CareRequirementsRepository {
  final SupabaseClient _client;
  SupabaseCareRequirementsRepsoitory(this._client);

  @override
  Future<CareRequirements> createCareRequirements(
    String plantId,
    String careType,
    int careFrequency,
  ) async {
    final user = _client.auth.currentUser;
    final map = await _client
        .from("plants")
        .select()
        .eq("plant_id", plantId)
        .single();
    if (user == null) throw Exception('need user');
    if (map.isEmpty) throw Exception("need plant");
    final result = await _client
        .from("care_requirements")
        .insert({
          "plant_id": plantId,
          "care_type": careType,
          "care_frequency": careFrequency,
        })
        .select()
        .single();

    return CareRequirementsMapper.fromMap(result);
  }

  @override
  Future<void> deleteCareRequirements(String careId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      return;
    }

    final result = await _client
        .from("care_requirements")
        .select()
        .eq("care_id", careId)
        .maybeSingle();

    if (result == null) {
      if (kDebugMode) print("🔥 DEBUG: Aucun enregistrement trouvé");
      return;
    }

    try {
      final deleteResult = await _client
          .from("care_requirements")
          .delete()
          .eq("care_id", careId);
      if (kDebugMode) print("🔥 DEBUG: Suppression réussie: $deleteResult");
    } catch (e) {
      if (kDebugMode) print("🔥 DEBUG: Erreur lors de la suppression: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateCareRequirements(CareRequirements careRequirements) async {
    final user = _client.auth.currentUser;
    final map = await _client
        .from("care_requirements")
        .select()
        .eq("care_id", careRequirements.careId)
        .single();
    if (user == null) return;
    if (map.isEmpty) throw Exception("care requirements don't exist");
    await _client
        .from("care_requirements")
        .update(careRequirements.toMap())
        .eq("care_id", careRequirements.careId);
  }

  @override
  Stream<List<CareRequirements>> watchCareRequirements(String plantId) {
    final stream = _client
        .from("care_requirements")
        .stream(primaryKey: ["care_id"])
        .eq("plant_id", plantId)
        .order("created_at");
    return stream.map(
      (event) => event.map((e) => CareRequirementsMapper.fromMap(e)).toList(),
    );
  }

  @override
  Future<void> registerCareRecord(String careId) async {
    final user = _client.auth.currentUser;
    final map = await _client
        .from("care_requirements")
        .select()
        .eq("care_id", careId)
        .single();
    if (user == null) return;
    if (map.isEmpty) return;
    await _client.from("care_records").insert({"care_id": careId});
  }

  @override
  Stream<List<CareRecord>> watchCareRecords(String careId) {
    final stream = _client
        .from('care_records')
        .stream(primaryKey: ["record_id"])
        .eq("careId", careId)
        .order("created_at");
    return stream.map(
      (states) => states.map((map) => CareRecordMapper.fromMap(map)).toList(),
    );
  }
}
